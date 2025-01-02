///|
pub fn scroll_to_pos[M](x : Int, y : Int) -> Command[M] {
  fn(_events, update) { @ffi.scroll_to(x, y) }
}

///|
pub fn scroll_by_pos[M](x : Int, y : Int) -> Command[M] {
  fn(_events, update) { @ffi.scroll_by(x, y) }
}

///|
pub fn scroll_to[M](element : String) -> Command[M] {
  fn(_events, update) { @ffi.get_element_by_id(element).scroll_into_view() }
}

///|
pub fn scroll_to_top[M]() -> Command[M] {
  fn(_events, update) { @ffi.scroll_to_top() }
}

///|
pub fn scroll_to_bottom[M]() -> Command[M] {
  fn(_events, update) { @ffi.scroll_to_bottom() }
}
