///|
enum Message {
  DrawPoint(@html.Mouse)
}

///|
struct Model {
  canvas : @canvas.Model[Message]
}

///|
fn update(msg : Message, model : Model) -> (@tea.Command[Message], Model) {
  match msg {
    DrawPoint(mouse) => {
      model.canvas
      .context2d()
      .fill_rect(
        mouse.offset_pos().x.to_double() - 5,
        mouse.offset_pos().y.to_double() - 5,
        10.0,
        10.0,
      )
      (@tea.none(), model)
    }
  }
}

///|
fn view(model : Model) -> @html.Html[Message] {
  div(style=["border: solid 1px gray; width: 500px; height: 500px"], [
    model.canvas.to_html(),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = {
    canvas: @canvas.new(width=500, height=500, mousemove=Message::DrawPoint),
  }
  @tea.startup(model~, update~, view~)
}
