///|
struct Model[Msg] {
  element : @dom.HTMLCanvasElement
  wrapper : @html.T[Msg]
}

///|
pub fn[Msg] context2d(self : Model[Msg]) -> Context2D {
  self.element.get_context("2d").to0().unwrap()
}

///|
pub fn[Msg] new(
  width~ : Double,
  height~ : Double,
  click? : (@html.Mouse) -> Msg,
  mousemove? : (@html.Mouse) -> Msg,
  mousedown? : (@html.Mouse) -> Msg,
  mouseup? : (@html.Mouse) -> Msg,
  mouseenter? : (@html.Mouse) -> Msg,
  mouseleave? : (@html.Mouse) -> Msg
) -> Model[Msg] {
  let canvas = @dom.document().create_element("canvas")
  let attributes = {
    let attrs = [
      @html.attribute("width", width.to_string()),
      @html.attribute("height", height.to_string()),
    ]
    [
      click.map(@html.on_click),
      mousemove.map(@html.on_mouse_move),
      mousedown.map(@html.on_mouse_down),
      mouseup.map(@html.on_mouse_up),
      mouseenter.map(@html.on_mouse_enter),
      mouseleave.map(@html.on_mouse_leave),
    ].each(x => match x {
      None => ()
      Some(attr) => attrs.push(attr)
    })
    @ref.new(Some(attrs))
  }
  let element = canvas
    .to_html_element()
    .unwrap()
    .to_html_canvas_element()
    .unwrap()
  let node = canvas.to_node()
  {
    element,
    wrapper: @html.external(
      node,
      attributes,
      width=width.to_int(),
      height=height.to_int(),
    ),
  }
}

///|
pub fn[Msg] to_html(self : Model[Msg]) -> @html.T[Msg] {
  self.wrapper
}
