///|
fnalias @tea.none

///|
fnalias @html.(h1, div, text, select, option)

///|
typealias @tea.Cmd

///|
typealias @html.Html

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
    select(change=SelectChange(_), disabled=false, [
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
