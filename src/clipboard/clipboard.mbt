///|
pub(all) enum Item {
  Text(String)
}

///| Returns a command that copies the given item to the clipboard.
/// 
/// # Message
/// 
/// - `copied` is triggered if the copy operation is successful.
/// - `failed` is triggered with the error message if the copy operation fails.
pub fn[M] copy(item : Item, copied? : M, failed? : (String) -> M) -> Cmd[M] {
  fn(dispatcher) {
    @js.async_run(fn() {
      try {
        guard item is Text(text)  //TODO: support other formats
        @dom.window().navigator().clipboard().write_text(text).wait() |> ignore
        match copied {
          Some(msg) => dispatcher.trigger_update(msg)
          None => ()
        }
      } catch {
        e =>
          match failed {
            Some(to_msg) => dispatcher.trigger_update(to_msg(e.to_string()))
            None => ()
          }
      }
    })
  }
}

///| Returns a command that pastes the clipboard content and returns it as an item.
/// 
/// # Message
/// - `pasted` is triggered with the pasted item if the paste operation is successful.
/// - `failed` is triggered with the error message if the paste operation fails.
pub fn[M] paste(pasted~ : (Item) -> M, failed? : (String) -> M) -> Cmd[M] {
  fn(dispatcher) {
    @js.async_run(fn() {
      try {
        // TODO: support other formats
        let str : String = @dom.window()
          .navigator()
          .clipboard()
          .read_text()
          .wait()
          |> @js.Value::cast()
        dispatcher.trigger_update(pasted(Text(str)))
      } catch {
        e =>
          match failed {
            Some(to_msg) => dispatcher.trigger_update(to_msg(e.to_string()))
            None => ()
          }
      }
    })
  }
}
