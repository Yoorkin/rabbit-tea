///| Create a command to scroll the window to a specific position.
pub fn[M] scroll_to_pos(x : Int, y : Int) -> Cmd[M] {
  _ => @dom.window().scroll_to(x, y)
}

///| Create a command to scroll the window by a specific amount.
pub fn[M] scroll_by_pos(x : Int, y : Int) -> Cmd[M] {
  _ => @dom.window().scroll_by(x, y)
}

///| Create a command to scroll the window to a specific element.
/// The element is specified by its id.
pub fn[M] scroll_to(element : String) -> Cmd[M] {
  _ => match @dom.document().get_element_by_id(element).to_option() {
    Some(e) => e.scroll_into_view()
    None => ()
  }
}

///| Create a command to scroll the window to the top.
pub fn[M] scroll_to_top() -> Cmd[M] {
  _ => @dom.window().scroll_to_top()
}

///| Create a command to scroll the window to the bottom.
pub fn[M] scroll_to_bottom() -> Cmd[M] {
  _ => @dom.window().scroll_to_bottom()
}
