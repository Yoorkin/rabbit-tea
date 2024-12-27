///|
pub typealias Command[M] = @adapter.Command[M]

///| @alert deprecated "Use `@command.None` instead"
pub fn none[M]() -> @command.T[M] {
  None
}

///| @alert deprecated "Use `@command.Batch` instead"
pub fn batch[M](xs : Array[Command[M]]) -> @command.T[M] {
  Batch(xs)
}

///| @alert deprecated "Use `@command.Task` instead"
pub fn task[M](message : M) -> @command.T[M] {
  Message(message)
}

///| Start the application.
pub fn startup[Model, Message](
  model~ : Model,
  update~ : (Message, Model) -> (Command[Message], Model),
  view~ : (Model) -> @html.Html[Message],
  initialize? : Message
) -> Unit {
  let mut sandbox = None
  fn after_update(html : @html.Html[Message]) {
    html.to_virtual_dom(sandbox.unwrap()).patch(sandbox.unwrap())
  }

  sandbox = Some(@adapter.new(model, update, view, after_update~))
  match initialize {
    Some(msg) => sandbox.unwrap().update(msg)
    _ => ()
  }
  sandbox.unwrap().refersh()
}
