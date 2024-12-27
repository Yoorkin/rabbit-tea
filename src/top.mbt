///|
pub typealias Command[M] = @adapter.Command[M]

///|
pub fn none[M]() -> Command[M] {
  @adapter.none()
}

///|
pub fn batch[M](xs : Array[Command[M]]) -> Command[M] {
  @adapter.batch(xs)
}

///|
pub fn task[M](message : M) -> Command[M] {
  @adapter.task(message)
}

///| Start the application.
pub fn startup[Model, Message](
  model~ : Model,
  update~ : (Message, Model) -> (Command[Message], Model),
  view~ : (Model) -> @html.Html[Message],
  initialize? : Message,
  url_changed? : (@adapter.UrlRequest) -> Message,
  url_request? : (@adapter.UrlRequest) -> Message
) -> Unit {
  let mut sandbox = None
  fn after_update(html : @html.Html[Message]) {
    html.to_virtual_dom(sandbox.unwrap()).patch(sandbox.unwrap())
  }

  sandbox = Some(
    @adapter.new(model, update, view, after_update~, url_changed?, url_request?),
  )
  match initialize {
    Some(msg) => sandbox.unwrap().update(msg)
    _ => ()
  }
  sandbox.unwrap().refersh()
}
