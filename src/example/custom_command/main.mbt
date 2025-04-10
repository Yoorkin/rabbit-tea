///|
fnalias @html.(text, button, div)

///|
enum Message {
  TimeUp(String)
  Clear
  SetTime
}

///|
struct Model {
  text : String
}

///|
extern "js" fn set_timeout(f : () -> Unit, ms : Int) = "(f,ms) => setTimeout(f, ms)"

///| Custom command to delay the message `msg` for `ms` milliseconds.
fn delay[M](msg : M, ms : Int) -> @cmd.Cmd[M] {
  @cmd.Cmd(fn(events) { set_timeout(fn() { events.trigger_update(msg) }, ms) })
}

///|
fn update(msg : Message, model : Model) -> (@cmd.Cmd[Message], Model) {
  match msg {
    TimeUp(text) => (@cmd.none(), { text: "TimeUp: \{text}" })
    Clear => (@cmd.none(), { text: "" })
    SetTime => (delay(TimeUp("delayed 5000ms"), 5000), model)
  }
}

///|
fn view(model : Model) -> @html.Html[Message] {
  div([
    button(click=Message::Clear, [text("Clear")]),
    button(click=Message::SetTime, [text("show text after 5s")]),
    text(model.text),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = { text: "" }
  @tea.startup(model~, update~, view~)
}
