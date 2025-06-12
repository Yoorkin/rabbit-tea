///| Create a command to go back in history. 
/// This will cause the page to reload.
pub fn[M] back() -> Cmd[M] {
  fn(_) { @dom.window().history_go_back() }
}

///| Create a command to go forward in history. 
/// This will cause the page to reload.
pub fn[M] forward() -> Cmd[M] {
  fn(_) { @dom.window().history_go_forward() }
}

///| Create a command to load a new URL. 
/// This will cause the page to reload.
pub fn[M] load(url : String) -> Cmd[M] {
  fn(_) { @dom.window().load_url(url) }
}

///| Create a command to reload the current url.
pub fn[M] reload() -> Cmd[M] {
  fn(_) { @dom.window().reload_url() }
}

///| Create a command to push a new URL to history but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn[M] push_url(url : String) -> Cmd[M] {
  fn(events : @cmd.Events[M]) {
    @dom.window().push_url(url)
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    events.trigger_url_changed(url)
  }
}

///| Create a command to change the URL but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn[M] replace_url(url : String) -> Cmd[M] {
  fn(events : @cmd.Events[M]) {
    @dom.window().replace_url(url)
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    events.trigger_url_changed(url)
  }
}
