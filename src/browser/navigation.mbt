///|
pub(all) enum UrlRequest {
  Internal(@url.Url)
  External(String)
} derive(Show, Eq, Compare)

///| go back in history. This will cause page to reload.
pub fn back[M]() -> Command[M] {
  fn(_events, update) { @ffi.history_go_back() }
}

///| go forward in history. This will cause page to reload.
pub fn forward[M]() -> Command[M] {
  fn(_events, update) { @ffi.history_go_forward() }
}

///| load a new url. This will cause page to reload.
pub fn load[M](url : String) -> Command[M] {
  fn(_events, update) { @ffi.load_url(url) }
}

///| reload the current url.
pub fn reload[M]() -> Command[M] {
  fn(_events, update) { @ffi.reload_url() }
}

///| push a new url to history but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn push_url[M](url : String) -> Command[M] {
  fn(events, update) {
    @ffi.push_url(url)
    guard let Ok(url) = @url.parse?(@ffi.current_url())
    (events.on_url_changed)(url)
  }
}

///| Change the url but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn replace_url[M](url : String) -> Command[M] {
  fn(events, update) {
    @ffi.replace_url(url)
    guard let Ok(url) = @url.parse?(@ffi.current_url())
    (events.on_url_changed)(url)
  }
}
