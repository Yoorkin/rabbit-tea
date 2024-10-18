pub enum Expecting[Msg] {
  Json((Result[Json, String]) -> Msg)
  Text((Result[String, String]) -> Msg)
}

extern "js" fn js_request(
  url : String,
  method : String,
  ~body : String,
  ~succeed : (String) -> Unit,
  ~failed : (String) -> Unit
) =
  #| (url,method,body,succeed,failed) => 
  #|   fetch(url, (body === "" ? { method: method } : { method: method, body: body }))
  #|   .then(response => response.text())
  #|   .then(json => succeed(json))
  #|   .catch(error => {
  #|     console.log(error);
  #|     failed(error.toString())
  #|   })
  #|

fn request[M](
  url : String,
  method : String,
  ~expect : Expecting[M],
  ~body : String = ""
) -> @adapter.Command[M] {
  let launch = fn(fulfill) {
    match expect {
      Json(f) =>
        js_request(
          url,
          method,
          ~body,
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
          method,
          ~body,
          succeed=fn(str) { fulfill(f(Ok(str))) },
          failed=fn(msg) { fulfill(f(Err("Http request failed:\{msg}"))) },
        )
    }
  }
  @adapter.Custom(launch)
}

pub fn get[M](url : String, ~expect : Expecting[M]) -> @adapter.Command[M] {
  request(url, "GET", ~expect)
}

pub fn delete[M](url : String, ~expect : Expecting[M]) -> @adapter.Command[M] {
  request(url, "DELETE", ~expect)
}

pub fn post[M](
  url : String,
  body : String,
  ~expect : Expecting[M]
) -> @adapter.Command[M] {
  request(url, "POST", ~body, ~expect)
}

pub fn patch[M](
  url : String,
  body : String,
  ~expect : Expecting[M]
) -> @adapter.Command[M] {
  request(url, "PATCH", ~body, ~expect)
}
