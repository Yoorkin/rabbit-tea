///| Url
/// 
/// ```text
///  https://example.com:8042/over/there?name=ferret#nose
///  \___/   \______________/\_________/ \_________/ \__/
///    |            |            |            |        |
///  scheme     authority       path        query   fragment
/// ```
/// 
/// This diagram is from https://package.elm-lang.org/packages/elm/url/latest/Url
pub(all) struct Url {
  protocol : Protocol
  host : String
  port : Int?
  path : String
  query : String?
  fragment : String?
} derive(Show, Eq, Compare)

///|
pub(all) enum Protocol {
  Http
  Https
  Other(String)
} derive(Show, Eq, Compare)

///|
pub fn to_string(self : Url) -> String {
  let protocol = match self.protocol {
    Http => "http"
    Https => "https"
  }
  let port = match self.port {
    Some(p) => ":\{p}"
    None => ""
  }
  let query = match self.query {
    Some(q) => "?\{q}"
    None => ""
  }
  let fragment = match self.fragment {
    Some(f) => "#\{f}"
    None => ""
  }
  "\{protocol}://\{self.host}\{port}/\{self.path}\{query}\{fragment}"
}

///|
pub fn parse(url : String) -> Url!Error {
  let (protocol, remain) = match url.split("://").collect() {
    ["http", remain] => (Http, remain)
    ["https", remain] => (Https, remain)
    [x, remain] => (Other(x), remain)
    [remain] => (Other(""), remain)
    _ => fail!("Invalid protocol")
  }
  let (mid, remain) = match remain.split("?").collect() {
    [mid, remain] => (mid, remain)
    [mid] => (mid, "")
    _ => fail!("Invalid host")
  }
  let (mid, path) = match mid.split("/").collect() {
    [mid, .. paths] =>
      (mid, String::concat(paths.iter().collect(), separator="/"))
    [mid] => (mid, "")
    _ => fail!("Invalid host")
  }
  let (host, port) = match mid.split(":").collect() {
    [host, port] => {
      let port = try {
        @strconv.parse_int!(port)
      } catch {
        _ => Option::None
      } else {
        number => Some(number)
      }
      (host, port)
    }
    [host] => (host, None)
    _ => fail!("Invalid host")
  }
  let (query, fragment) = match remain.split("#").collect() {
    [query, fragment] => (Some(query), Some(fragment))
    [query] => (Some(query), None)
    [] => (None, None)
    _ => fail!("Invalid query")
  }
  { protocol, host, port, path, query, fragment }
}
