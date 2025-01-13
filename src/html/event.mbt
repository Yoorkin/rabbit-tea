///|
pub fn on_click[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("click", Normal(msg))
}

///|
pub fn on_input[Msg](msg : (String) -> Msg) -> Attribute[Msg] {
  @vdom.on("input", HandleEvent(fn(event) { event.target().value() |> msg }))
}

///|
pub fn on_change[Msg](msg : (String) -> Msg) -> Attribute[Msg] {
  @vdom.on("change", HandleEvent(fn(event) { event.target().value() |> msg }))
}

///|
pub fn on_double_click[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("dblclick", Normal(msg))
}

///|
pub fn on_mouse_down[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("mousedown", Normal(msg))
}

///|
pub fn on_mouse_up[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("mouseup", Normal(msg))
}

///|
pub fn on_mouse_enter[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("mouseenter", Normal(msg))
}

///|
pub fn on_mouse_over[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("mouseover", Normal(msg))
}

///|
pub fn on_mouse_leave[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("mouseleave", Normal(msg))
}

///|
pub fn on_mouse_out[Msg](msg : Msg) -> Attribute[Msg] {
  @vdom.on("mouseout", Normal(msg))
}
