///| Create a command to go back in history. 
/// This will cause the page to reload.
pub fn back[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().history_go_back() }
}

///| Create a command to go forward in history. 
/// This will cause the page to reload.
pub fn forward[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().history_go_forward() }
}

///| Create a command to load a new URL. 
/// This will cause the page to reload.
pub fn load[M](url : String) -> Cmd[M] {
  fn(_, _) { @dom.window().load_url(url) }
}

///| Create a command to reload the current url.
pub fn reload[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().reload_url() }
}

///| Create a command to push a new URL to history but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn push_url[M](url : String) -> Cmd[M] {
  fn(events : @cmd.PredefinedEvent, _) {
    @dom.window().push_url(url)
    guard @url.parse?(@dom.window().current_url()) is Ok(url)
    (events.on_url_changed)(url)
  }
}

///| Create a command to change the URL but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn replace_url[M](url : String) -> Cmd[M] {
  fn(events : @cmd.PredefinedEvent, _) {
    @dom.window().replace_url(url)
    guard @url.parse?(@dom.window().current_url()) is Ok(url)
    (events.on_url_changed)(url)
  }
}
