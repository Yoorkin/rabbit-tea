///|
pub typealias Command[M] = @browser.Command[M]

///|
pub fn none[M]() -> Command[M] {
  @browser.none()
}

///|
pub fn batch[M](xs : Array[Command[M]]) -> Command[M] {
  @browser.batch(xs)
}

///|
pub fn task[M](message : M) -> Command[M] {
  @browser.task(message)
}

///| Start the application.
pub fn startup[Model, Message](
  model~ : Model,
  update~ : (Message, Model) -> (Command[Message], Model),
  view~ : (Model) -> @html.Html[Message],
  initialize? : Message,
  url_changed? : (@browser.UrlRequest) -> Message,
  url_request? : (@browser.UrlRequest) -> Message
) -> Unit {
  let mut sandbox = None
  fn after_update(html : @html.Html[Message]) {
    html.to_virtual_dom(sandbox.unwrap()).patch(sandbox.unwrap())
  }

  sandbox = Some(
    @browser.new(model, update, view, after_update~, url_changed?, url_request?),
  )
  match initialize {
    Some(msg) => sandbox.unwrap().update(msg)
    _ => ()
  }
  sandbox.unwrap().refersh()
}
