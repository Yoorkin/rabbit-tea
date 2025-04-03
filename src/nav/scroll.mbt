///| Create a command to scroll the window to a specific position.
pub fn scroll_to_pos[M](x : Int, y : Int) -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_to(x, y) }
}

///| Create a command to scroll the window by a specific amount.
pub fn scroll_by_pos[M](x : Int, y : Int) -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_by(x, y) }
}

///| Create a command to scroll the window to a specific element.
/// The element is specified by its id.
pub fn scroll_to[M](element : String) -> Cmd[M] {
  fn(_, _) {
    match @dom.document().get_element_by_id(element).to_option() {
      Some(e) => e.scroll_into_view()
      None => ()
    }
  }
}

///| Create a command to scroll the window to the top.
pub fn scroll_to_top[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_to_top() }
}

///| Create a command to scroll the window to the bottom.
pub fn scroll_to_bottom[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_to_bottom() }
}
