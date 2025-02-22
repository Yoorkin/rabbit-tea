///|
test "basic_url" {
  let a = "http://localhost:5173/abcd"
  inspect!(
    @url.parse?(a),
    content=
      #|Ok({protocol: Http, host: "localhost", port: Some(5173), path: "abcd", query: None, fragment: None})
    ,
  )
  inspect!(
    @url.parse?("https://example.com"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: None, path: "", query: None, fragment: None})
    ,
  )
  inspect!(
    @url.parse?("https://example.com/"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: None, path: "", query: None, fragment: None})
    ,
  )
  inspect!(
    @url.parse?("https://example.com/path1/path2"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: None, path: "path1/path2", query: None, fragment: None})
    ,
  )
  inspect!(
    @url.parse?("https://example.com:8080/path/to/somewhere?query#fragment"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: Some("query"), fragment: Some("fragment")})
    ,
  )
  inspect!(
    @url.parse?(
      "https://example.com:8080/path/to/somewhere?key=value&key2=value2#fragment",
    ),
    content=
      #|Ok({protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: Some("key=value&key2=value2"), fragment: Some("fragment")})
    ,
  )
}

///|
test "special url" {
  inspect!(
    @url.parse?("localhost:8080/abcd"),
    content=
      #|Ok({protocol: Other(""), host: "localhost", port: Some(8080), path: "abcd", query: None, fragment: None})
    ,
  )
}

///|
test "no_port" {
  inspect!(
    @url.parse?("https://example.com/path/to/somewhere?query#fragment"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: None, path: "path/to/somewhere", query: Some("query"), fragment: Some("fragment")})
    ,
  )
}

///|
test "no_query" {
  inspect!(
    @url.parse?("https://example.com:8080/path/to/somewhere#fragment"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: None, fragment: Some("fragment")})
    ,
  )
}

///|
test "no_fragment" {
  inspect!(
    @url.parse?("https://example.com:8080/path/to/somewhere?query"),
    content=
      #|Ok({protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: Some("query"), fragment: None})
    ,
  )
}
