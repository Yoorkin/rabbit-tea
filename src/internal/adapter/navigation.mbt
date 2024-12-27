///|
pub(all) enum UrlRequest {
  Internal(@url.Url)
  External(@url.Url)
}

///|
extern "js" fn ffi_go_back() =
  #| () => { window.history.back(); }

///|
extern "js" fn ffi_go_forward() =
  #| () => { window.history.forward(); }

///|
extern "js" fn ffi_load_url(url : String) =
  #| (url) => { window.location.href = url; }

///|
extern "js" fn ffi_reload_url() =
  #| () => { window.location.reload(); }

///|
extern "js" fn ffi_push_url(url : String) =
  #| (url) => { window.history.pushState(null, '', url); }

///|
extern "js" fn ffi_current_url() -> String =
  #| () => { return window.location.href; }

///|
extern "js" fn ffi_replace_url(url : String) =
  #| (url) => { window.history.replaceState(null, '', url); }

///|
pub fn back[M]() -> Command[M] {
  fn(_events, update) { ffi_go_back() }
}

///|
pub fn forward[M]() -> Command[M] {
  fn(_events, update) { ffi_go_forward() }
}

///|
pub fn load[M](url : String) -> Command[M] {
  fn(_events, update) { ffi_load_url(url) }
}

///|
pub fn reload[M]() -> Command[M] {
  fn(_events, update) { ffi_reload_url() }
}

///|
pub fn push_url[M](url : String) -> Command[M] {
  fn(events, update) {
    ffi_push_url(url)
    let request = Internal(@url.parse(url))
    (events.on_url_changed)(request)
  }
}

///| 
pub fn replace_url[M](url : String) -> Command[M] {
  fn(events, update) {
    ffi_replace_url(url)
    let request = Internal(@url.parse(url))
    (events.on_url_changed)(request)
  }
}
