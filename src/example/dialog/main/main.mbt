///|
fnalias @tea.none

///|
fnalias @html.(h1, div, text, button, dialog, input)

///|
typealias @tea.Cmd

///|
typealias @html.Html

///|
priv struct Model {
  title : String
  input : String
} derive(Show)

///|
enum Msg {
  Edit
  Save
  Discard
  AboutToClose
  DialogClosed(String)
  InputChanged(String)
}

///|
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  println(model)
  match msg {
    Edit => (@dialog.show("menu", modal=true), { ..model, input: model.title })
    Save => (@dialog.close("menu", return_value=model.input), model)
    Discard => (@dialog.request_close("menu", return_value=model.title), model)
    AboutToClose => {
      let cmd = if model.input == model.title ||
        @dom.window().confirm("Are you sure?") {
        @dialog.close("menu", return_value=model.title)
      } else {
        none()
      }
      (cmd, model)
    }
    DialogClosed(title) => (none(), { ..model, title, })
    InputChanged(input) => (none(), { ..model, input, })
  }
}

///|
fn view(model : Model) -> Html[Msg] {
  div([
    h1([text(model.title)]),
    button(click=Msg::Edit, [text("edit")]),
    dialog(id="menu", cancel=Msg::AboutToClose, close=DialogClosed(_), [
      h1([text("edit the title")]),
      input(input_type=Text, value=model.input, input=InputChanged(_)),
      button(click=Msg::Discard, [text("discard")]),
      button(click=Msg::Save, [text("save")]),
    ]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = { title: "Hello World", input: "" }
  @tea.startup(model~, update~, view~)
}
