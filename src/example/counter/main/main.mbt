///|
fnalias @tea.none

///|
fnalias @html.(h1, div, text, button)

///|
typealias @tea.Cmd

///|
typealias @html.Html

///|
typealias Int as Model

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
    button(click=Increment, [text("+")]),
    button(click=Decrement, [text("-")]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = 0
  @tea.startup(model~, update~, view~)
}
