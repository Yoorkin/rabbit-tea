///|
type Mouse @dom.MouseEvent

///|
pub(all) struct Pos {
  x : Int
  y : Int
}

///|
pub fn Mouse::screen_pos(self : Mouse) -> Pos {
  { x: self.inner().screen_x(), y: self.inner().screen_y() }
}

///|
pub fn Mouse::offset_pos(self : Mouse) -> Pos {
  { x: self.inner().offset_x(), y: self.inner().offset_y() }
}

///|
pub fn Mouse::client_pos(self : Mouse) -> Pos {
  { x: self.inner().client_x(), y: self.inner().client_y() }
}

///|
type Scroll @dom.Element

///|
pub fn Scroll::offset_pos(self : Self) -> Pos {
  {
    x: self.inner().get_scroll_left().to_int(),
    y: self.inner().get_scroll_top().to_int(),
  }
}

///|
pub fn Scroll::width(self : Self) -> Int {
  self.inner().get_scroll_width().to_int()
}

///|
pub fn Scroll::height(self : Self) -> Int {
  self.inner().get_scroll_height().to_int()
}

///|
fn[Msg] on_mouse(event : String, msg : (Mouse) -> Msg) -> Attribute[Msg] {
  @vdom.on(
    event,
    HandleEvent(event => msg(
      event
      .to_ui_event()
      .to_option()
      .unwrap()
      .to_mouse_event()
      .to_option()
      .unwrap(),
    )),
  )
}

///|
pub fn[Msg] on_click(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("click", msg)
}

///|
pub fn[Msg] on_input(msg : (String) -> Msg) -> Attribute[Msg] {
  @vdom.on(
    "input",
    HandleEvent(event => {
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
pub fn[Msg] on_change(msg : (String) -> Msg) -> Attribute[Msg] {
  @vdom.on(
    "change",
    HandleEvent(event => {
      // TODO: eliminate to_option
      let html_element = event
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
      let value = if html_element.to_html_input_element().to_option() is Some(x) {
        x.value()
      } else if html_element.to_html_select_element().to_option() is Some(x) {
        x.value()
      } else {
        panic() // TODO: check for other HTMLElement types
      }
      msg(value)
    }),
  )
}

///|
pub fn[Msg] on_double_click(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("dblclick", msg)
}

///|
pub fn[Msg] on_mouse_down(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mousedown", msg)
}

///|
pub fn[Msg] on_mouse_up(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseup", msg)
}

///|
pub fn[Msg] on_mouse_move(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mousemove", msg)
}

///|
pub fn[Msg] on_mouse_enter(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseenter", msg)
}

///|
pub fn[Msg] on_mouse_over(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseover", msg)
}

///|
pub fn[Msg] on_mouse_leave(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseleave", msg)
}

///|
pub fn[Msg] on_mouse_out(msg : (Mouse) -> Msg) -> Attribute[Msg] {
  on_mouse("mouseout", msg)
}

///|
pub fn[M] on_scroll(msg : (Scroll) -> M) -> Attribute[M] {
  @vdom.on(
    "scroll",
    HandleEvent(event => msg(
      // TODO: eliminate to_option
      event
      .target()
      .to_node()
      .to_option()
      .unwrap()
      .to_element()
      .to_option()
      .unwrap(),
    )),
  )
}
