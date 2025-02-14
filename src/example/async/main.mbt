// README: 
// This example demonstrates how to manually wrap an async JS FFI in Moonbit. 
// 
// This example is particularly useful when the functionality is not 
// yet available in the rabbit-tea library. Ideally, the Core library should 
// provide basic async utilities, but in this early stage, we need to implement 
// the wrapping ourselves. 
// 
// If you are looking for HTTP request functionality, you can use the `rabbit-tea/http` package.

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
fn update(msg : Message, model : Model) -> (@tea.Command[Message], Model) {
  match msg {
    TimeUp(text) => (@tea.none(), { text: "TimeUp \{text}" })
    Clear => (@tea.none(), { text: "" })
    SetTime => {
      let f = async fn() {
        suspend!!(fn(resolve) { set_timeout(fn() { resolve(()) }, 5000) })
        "5000"
      }
      (@tea.perform(Message::TimeUp, f), model)
    }
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
