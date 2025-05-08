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
pub async fn suspend[T](f : ((T) -> Unit) -> Unit) -> T = "%async.suspend"

///|
extern "js" fn set_timeout(f : () -> Unit, ms : Int) = "(f,ms) => setTimeout(f, ms)"

///|
fn update(msg : Message, model : Model) -> (@tea.Cmd[Message], Model) {
  match msg {
    TimeUp(text) => (@tea.none(), { text: "TimeUp \{text}" })
    Clear => (@tea.none(), { text: "" })
    SetTime => {
      let f = async fn() {
        suspend!(fn(resolve) { set_timeout(fn() { resolve(()) }, 5000) })
        "5000"
      }
      (@tea.perform(TimeUp(_), f), model)
    }
  }
}

///|
fn view(model : Model) -> @html.Html[Message] {
  div([
    button(click=Clear, [text("Clear")]),
    button(click=SetTime, [text("show text after 5s")]),
    text(model.text),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = { text: "" }
  @tea.startup(model~, update~, view~)
}
