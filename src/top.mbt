///|
pub typealias Command[M] = @adapter.Command[M]

///|
pub fn none[M]() -> Command[M] {
  @adapter.None
}

///|
pub fn batch[M](xs : Array[Command[M]]) -> Command[M] {
  @adapter.Batch(xs)
}

///|
pub fn task[M](message : M) -> @adapter.Command[M] {
  @adapter.Message(message)
}

///|
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
