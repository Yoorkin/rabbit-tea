///|
fnalias @tea.none

///|
fnalias @html.(h1, div, text, button, select, option)

///|
typealias @tea.Cmd[M]

///|
typealias @html.Html[M]

///|
typealias Model = String

///|
enum Msg {
  SelectChange(String)
}

///|
fn update(msg : Msg, _ : Model) -> (Cmd[Msg], Model) {
  match msg {
    SelectChange(selected) => (none(), selected)
  }
}

///|
fn view(model : Model) -> Html[Msg] {
  div([
    h1([text(model)]),
    select(change=SelectChange, disabled=false, [
      option(value="plan A", selected=false, [text("plan A")]),
      option(value="plan B", [text("plan B")]),
      option(value="plan C", [text("plan C")]),
    ]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = "plan A"
  @tea.startup(model~, update~, view~)
}
