///|
fnalias @tea.none

///|
fnalias @html.(p, div, text, button)

///|
typealias @tea.Cmd

///|
typealias @html.Html

///|
struct Model {
  tips : String
  copied : Bool
}

///|
enum Msg {
  Copy(String)
  Paste
  GotPasteData(@clipboard.Item)
  OnError(String)
  OnCopySucceed
}

///|
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  match msg {
    Copy(text) => {
      let cmd = @clipboard.copy(
        Text(text),
        copied=OnCopySucceed,
        failed=OnError(_),
      )
      (cmd, { ..model, copied: false })
    }
    Paste =>
      (
        @clipboard.paste(pasted=GotPasteData(_), failed=OnError(_)),
        { ..model, copied: false },
      )
    GotPasteData(Text(tips)) => (none(), { ..model, tips, })
    OnError(err) => (none(), { ..model, tips: err })
    OnCopySucceed => (none(), { ..model, copied: true })
  }
}

///|
fn view(model : Model) -> Html[Msg] {
  let { tips, copied } = model
  div([
    p([text(tips.to_string())]),
    button(click=Msg::Copy(tips), [
      text(if copied { "copied!" } else { "copy" }),
    ]),
    button(click=Msg::Paste, [text("paste")]),
  ])
}

///| NOTE: This program is only available in the js backend, 
/// see README.md to getting started.
fn main {
  let model = { tips: "moon add Yoorkin/rabbit-tea", copied: false }
  @tea.startup(model~, update~, view~)
}
