///|
pub(all) enum Expecting[Msg, Model] {
  Json((Result[Model, String]) -> Msg, (Json) -> Result[Model, String])
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
fn[Msg, Model] request(
  url : String,
  http_method : String,
  expect~ : Expecting[Msg, Model],
  body~ : Body
) -> @cmd.Cmd[Msg] {
  let launch = fn(events : @cmd.Events[Msg]) {
    let has_body = match body {
      Empty => false
      _ => true
    }
    let content_type = body.content_type()
    let body = body.stringfiy()
    match expect {
      Json(f, decoder) =>
        js_request(
          url,
          http_method,
          has_body~,
          body~,
          content_type~,
          succeed=str => {
            let result = Ok(@json.parse(str)) catch {
              _ => Err("Json parse error")
            }
            events.trigger_update(f(result.bind(decoder)))
          },
          failed=msg => events.trigger_update(
            f(Err("Http request failed:\{msg}")),
          ),
        )
      Text(f) =>
        js_request(
          url,
          http_method,
          has_body~,
          body~,
          content_type~,
          succeed=str => events.trigger_update(f(Ok(str))),
          failed=msg => events.trigger_update(
            f(Err("Http request failed:\{msg}")),
          ),
        )
    }
  }
  Cmd(launch)
}

///| Create a command to send a GET request.
pub fn[Msg, Model] get(
  url : String,
  expect~ : Expecting[Msg, Model]
) -> @cmd.Cmd[Msg] {
  request(url, "GET", expect~, body=Empty)
}

///| Create a command to send a PUT request.
pub fn[Msg, Model] delete(
  url : String,
  expect~ : Expecting[Msg, Model]
) -> @cmd.Cmd[Msg] {
  request(url, "DELETE", expect~, body=Empty)
}

///| Create a command to send a POST request.
pub fn[Msg, Model] post(
  url : String,
  body : Body,
  expect~ : Expecting[Msg, Model]
) -> @cmd.Cmd[Msg] {
  request(url, "POST", body~, expect~)
}

///| Create a command to send a PATCH request.
pub fn[Msg, Model] patch(
  url : String,
  body : Body,
  expect~ : Expecting[Msg, Model]
) -> @cmd.Cmd[Msg] {
  request(url, "PATCH", body~, expect~)
}
