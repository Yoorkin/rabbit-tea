///|
type Mouse @ffi.MouseEvent

///|
pub struct Pos {
  x : Int
  y : Int
}

///|
pub fn Mouse::screen_pos(self : Mouse) -> Pos {
  { x: self._.screen_x(), y: self._.screen_y() }
}

///|
pub fn Mouse::offset_pos(self : Mouse) -> Pos {
  { x: self._.offset_x(), y: self._.offset_y() }
}

///|
pub fn Mouse::client_pos(self : Mouse) -> Pos {
  { x: self._.client_x(), y: self._.client_y() }
}

///|
fn on_mouse[Msg](event : String, msg : (Mouse) -> Msg) -> Attribute[Msg] {
  @vdom.on(
    event,
    HandleEvent(fn(event) {
      msg(
        event
        .to_ui_event()
        .to_option()
        .unwrap()
        .to_mouse_event()
        .to_option()
        .unwrap(),
      )
    }),
  )
}

///|
pub fn on_click[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("click", msg)
}

///|
pub fn on_input[Msg](msg : (String) -> Msg) -> Attribute[Msg] {
  @vdom.on(
    "input",
    HandleEvent(fn(event) {
      // TODO: eliminate to_option
      let value : String = event
        .target()
        .to_node()
        .to_option()
        .unwrap()
        .to_element()
        .to_option()
        .unwrap()
        .to_html_element()
        .to_option()
        .unwrap()
        .to_html_input_element()
        .to_option()
        .unwrap()
        .value()
      msg(value)
    }),
  )
}

///|
pub fn on_change[Msg](msg : (String) -> Msg) -> Attribute[Msg] {
  @vdom.on(
    "change",
    HandleEvent(fn(event) {
      // TODO: eliminate to_option
      let value : String = event
        .target()
        .to_node()
        .to_option()
        .unwrap()
        .to_element()
        .to_option()
        .unwrap()
        .to_html_element()
        .to_option()
        .unwrap()
        .to_html_input_element()
        .to_option()
        .unwrap()
        .value()
      msg(value)
    }),
  )
}

///|
pub fn on_double_click[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("dblclick", msg)
}

///|
pub fn on_mouse_down[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mousedown", msg)
}

///|
pub fn on_mouse_up[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseup", msg)
}

///|
pub fn on_mouse_move[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mousemove", msg)
}

///|
pub fn on_mouse_enter[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseenter", msg)
}

///|
pub fn on_mouse_over[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseover", msg)
}

///|
pub fn on_mouse_leave[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseleave", msg)
}

///|
pub fn on_mouse_out[Msg](msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseout", msg)
}
