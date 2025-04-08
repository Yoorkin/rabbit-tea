///|
fnalias @tea.none

///|
fnalias @html.(h1, div, text, button)

///|
typealias @tea.Cmd[M]

///|
typealias @html.Html[M]

///|
struct Model {
  count : Int
  title : String
}

///|
enum Msg {
  Increment
  Decrement
}

///|
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  fn f() {
    if model.count % 2 == 1 {
      "Even"
    } else {
      "Odd"
    }
  }

  match msg {
    Increment => (none(), { title: f(), count: model.count + 1 })
    Decrement => (none(), { title: f(), count: model.count - 1 })
  }
}

///|
fn view(model : Model) -> Html[Msg] {
  div([
    h1([text(model.count.to_string())]),
    h1([text(model.title)]),
    button(click=Msg::Increment, [text("+")]),
    button(click=Msg::Decrement, [text("-")]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = { count: 0, title: "" }
  @tea.startup(model~, update~, view~).enable_devtool()
}
