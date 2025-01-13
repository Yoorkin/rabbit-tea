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
/// 
/// - `model` is the state of your application.
/// - `view` is a way to turn your model into HTML.
/// - `update` a way to update your state based on messages.
/// 
/// These three are the core of the TEA. Rabbit-TEA is highly unstable at this time, 
/// but it follows the same pattern as Elm. You can visit https://guide.elm-lang.org/ 
/// to get more intuition!
/// 
/// # More parameters 
/// 
/// - `url_changed` is a message that will be passed when the URL is changed by the navigation API in the `@browser` package.
/// - `url_request` is a message that will be passed when an `<a>` tag is clicked.
/// 
pub fn startup[Model, Message](
  model~ : Model,
  update~ : (Message, Model) -> (Command[Message], Model),
  view~ : (Model) -> @html.Html[Message],
  initialize? : Message,
  url_changed? : (@url.Url) -> Message,
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
