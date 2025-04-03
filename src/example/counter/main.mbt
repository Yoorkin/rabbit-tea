///|
fnalias @tea.none

///|
fnalias @html.(h1, div, text, button)

///|
typealias @tea.Cmd[M]

///|
typealias @html.Html[M]

///|
typealias Model = Int

///|
enum Msg {
  Increment
  Decrement
}

///|
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  match msg {
    Increment => (none(), model + 1)
    Decrement => (none(), model - 1)
  }
}

///|
fn view(model : Model) -> Html[Msg] {
  div([
    h1([text(model.to_string())]),
    button(click=Msg::Increment, [text("+")]),
    button(click=Msg::Decrement, [text("-")]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = 0
  @tea.startup(model~, update~, view~)
}
