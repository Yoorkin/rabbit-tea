///|
pub(all) enum UrlRequest {
  Internal(@url.Url)
  External(@url.Url)
} derive(Show, Eq, Compare)

///|
pub fn back[M]() -> Command[M] {
  fn(_events, update) { @ffi.history_go_back() }
}

///|
pub fn forward[M]() -> Command[M] {
  fn(_events, update) { @ffi.history_go_forward() }
}

///|
pub fn load[M](url : String) -> Command[M] {
  fn(_events, update) { @ffi.load_url(url) }
}

///|
pub fn reload[M]() -> Command[M] {
  fn(_events, update) { @ffi.reload_url() }
}

///|
pub fn push_url[M](url : String) -> Command[M] {
  fn(events, update) {
    @ffi.push_url(url)
    let request = Internal(@url.parse(url))
    (events.on_url_changed)(request)
  }
}

///| 
pub fn replace_url[M](url : String) -> Command[M] {
  fn(events, update) {
    @ffi.replace_url(url)
    let request = Internal(@url.parse(url))
    (events.on_url_changed)(request)
  }
}
