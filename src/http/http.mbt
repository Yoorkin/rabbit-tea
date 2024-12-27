///|
pub(all) enum Expecting[Msg] {
  Json((Result[Json, String]) -> Msg)
  Text((Result[String, String]) -> Msg)
}

///|
pub(all) enum Body {
  Json(Json)
  Text(String)
  Empty
}

///|
fn content_type(self : Body) -> String {
  match self {
    Json(_) => "application/json"
    Text(_) => "text/plain"
    Empty(_) => "text/plain"
  }
}

///|
fn stringfiy(self : Body) -> String {
  match self {
    Json(json) => json.stringify()
    Text(text) => text
    Empty => ""
  }
}

///|
extern "js" fn js_request(
  url : String,
  http_method : String,
  content_type~ : String,
  body~ : String,
  has_body~ : Bool,
  succeed~ : (String) -> Unit,
  failed~ : (String) -> Unit
) =
  #| (url,method,contentType,body,hasBody,succeed,failed) => {
  #|   var config = { method: method, headers: { 'Content-Type': contentType } }; 
  #|   if (hasBody) { config.body = body };
  #|   console.log("Requesting: ",url,config);
  #|   fetch(url, config)
  #|     .then(response => response.text())
  #|     .then(json => succeed(json))
  #|     .catch(error => {
  #|       console.log(error);
  #|       failed(error.toString())
  #|     })
  #| }

///|
fn request[M](
  url : String,
  http_method : String,
  expect~ : Expecting[M],
  body~ : Body
) -> @adapter.Command[M] {
  let launch = fn(fulfill) {
    let has_body = match body {
      Empty => false
      _ => true
    }
    let content_type = body.content_type()
    let body = body.stringfiy()
    match expect {
      Json(f) =>
        js_request(
          url,
          http_method,
          has_body~,
          body~,
          content_type~,
          succeed=fn(str) {
            let result = try {
              Ok(@json.parse!(str))
            } catch {
              _ => Err("Json parse error")
            }
            fulfill(f(result))
          },
          failed=fn(msg) { fulfill(f(Err("Http request failed:\{msg}"))) },
        )
      Text(f) =>
        js_request(
          url,
          http_method,
          has_body~,
          body~,
          content_type~,
          succeed=fn(str) { fulfill(f(Ok(str))) },
          failed=fn(msg) { fulfill(f(Err("Http request failed:\{msg}"))) },
        )
    }
  }
  Custom(launch)
}

///|
pub fn get[M](url : String, expect~ : Expecting[M]) -> @adapter.Command[M] {
  request(url, "GET", expect~, body=Empty)
}

///|
pub fn delete[M](url : String, expect~ : Expecting[M]) -> @adapter.Command[M] {
  request(url, "DELETE", expect~, body=Empty)
}

///|
pub fn post[M](
  url : String,
  body : Body,
  expect~ : Expecting[M]
) -> @adapter.Command[M] {
  request(url, "POST", body~, expect~)
}

///|
pub fn patch[M](
  url : String,
  body : Body,
  expect~ : Expecting[M]
) -> @adapter.Command[M] {
  request(url, "PATCH", body~, expect~)
}
