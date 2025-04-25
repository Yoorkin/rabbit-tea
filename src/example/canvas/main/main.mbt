///|
fnalias @html.(div, text, button)

///|
enum Message {
  Clear
  DrawPoint(@html.Mouse)
  MouseDown(@html.Mouse)
  MouseUp
  ChooseColor(@canvas.Color)
}

///|
struct Model {
  drawing : Drawing
  color : @canvas.Color
  canvas : @canvas.Model[Message]
}

///|
enum Drawing {
  Disabled
  Enabled(@html.Pos)
}

///|
fn update(msg : Message, model : Model) -> (@tea.Cmd[Message], Model) {
  match msg {
    Clear => {
      model.canvas.context2d().clear_rect(0.0, 0.0, 500.0, 500.0)
      (@tea.none(), model)
    }
    ChooseColor(color) => {
      model.canvas.context2d().set_stroke_style(color)
      (@tea.none(), { ..model, color, })
    }
    MouseDown(mouse) =>
      (@tea.none(), { ..model, drawing: Enabled(mouse.offset_pos()) })
    MouseUp(_) => (@tea.none(), { ..model, drawing: Disabled })
    DrawPoint(mouse) =>
      match model.drawing {
        Enabled({ x: lx, y: ly }) => {
          model.canvas
          .context2d()
          ..begin_path()
          ..move_to(lx.to_double(), ly.to_double())
          ..line_to(
            mouse.offset_pos().x.to_double(),
            mouse.offset_pos().y.to_double(),
          )
          .stroke()
          (@tea.none(), { ..model, drawing: Enabled(mouse.offset_pos()) })
        }
        Disabled => (@tea.none(), model)
      }
  }
}

///|
fn view(model : Model) -> @html.Html[Message] {
  div(style=["border: solid 1px gray; width: 500px; height: 500px"], [
    model.canvas.to_html(),
    div(style=["width:30px; height:30px", "background: \{model.color}"], []),
    button(click=Message::Clear, [text("Clear")]),
    button(click=Message::ChooseColor(RGB(255, 0, 0)), [text("Red")]),
    button(click=Message::ChooseColor(RGB(0, 255, 0)), [text("Green")]),
    button(click=Message::ChooseColor(RGB(0, 0, 255)), [text("Blue")]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = {
    drawing: Disabled,
    color: RGB(0, 0, 0),
    canvas: @canvas.new(
      width=500,
      height=500,
      mousemove=Message::DrawPoint,
      mousedown=Message::MouseDown,
      mouseup=fn(_) { Message::MouseUp },
    ),
  }
  @tea.startup(model~, update~, view~)
}
