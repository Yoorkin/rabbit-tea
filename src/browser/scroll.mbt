///|
pub fn scroll_to_pos[M](x : Int, y : Int) -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_to(x, y) }
}

///|
pub fn scroll_by_pos[M](x : Int, y : Int) -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_by(x, y) }
}

///|
pub fn scroll_to[M](element : String) -> Cmd[M] {
  fn(_, _) {
    match @dom.document().get_element_by_id(element).to_option() {
      Some(e) => e.scroll_into_view()
      None => ()
    }
  }
}

///|
pub fn scroll_to_top[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_to_top() }
}

///|
pub fn scroll_to_bottom[M]() -> Cmd[M] {
  fn(_, _) { @dom.window().scroll_to_bottom() }
}
