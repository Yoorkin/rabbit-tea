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

///|
pub fn perform[A, M](msg : (A) -> M, f : async () -> A) -> Command[M] {
  @browser.perform(msg, f)
}

///|
pub fn attempt[A, E : Error, M](
  msg : (Result[A, E]) -> M,
  f : async () -> A!E
) -> Command[M] {
  @browser.attempt(msg, f)
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
/// To start the application with router, you can use the `application` function.
pub fn startup[Model, Message](
  model~ : Model,
  update~ : (Message, Model) -> (Command[Message], Model),
  view~ : (Model) -> @html.Html[Message],
  mount~ : String = "app"
) -> Unit {
  @dom.document()
  .get_element_by_id(mount)
  .get_exn()
  .set_inner_html("<div></div>")
  let mut sandbox = None
  let mut curr_dom = @vdom.node("div", [], [])
  fn after_update(html : @html.Html[Message]) {
    guard let Some(sandbox) = sandbox
    let new_dom = html.to_virtual_dom()
    new_dom.patch(curr_dom, sandbox, mount~)
    curr_dom = new_dom
  }

  sandbox = Some(@browser.Sandbox::new(model, update, view, after_update~))
  sandbox.unwrap().refersh()
}

///| Start the application with initial URL. 
/// 
/// - `url_changed` is a message that will be passed when the URL is changed by the navigation API in the `@browser` package.
/// - `url_request` is a message that will be passed when an `<a>` tag is clicked.
/// - `initialize` will be called when the application is started. 
/// 
pub fn application[Model, Msg](
  initialize~ : (@url.Url) -> (Command[Msg], Model),
  update~ : (Msg, Model) -> (Command[Msg], Model),
  view~ : (Model) -> @html.Html[Msg],
  url_changed? : (@url.Url) -> Msg,
  url_request? : (@browser.UrlRequest) -> Msg,
  mount~ : String = "app"
) -> Unit {
  @dom.document()
  .get_element_by_id(mount)
  .get_exn()
  .set_inner_html("<div></div>")
  let mut sandbox = None
  let mut curr_dom = @vdom.node("div", [], [])
  fn after_update(html : @html.Html[Msg]) {
    guard let Some(sandbox) = sandbox
    let new_dom = html.to_virtual_dom()
    new_dom.patch(curr_dom, sandbox, mount~)
    curr_dom = new_dom
  }

  guard let Ok(url) = @url.parse?(@dom.window().current_url())
  let (cmd, model) = initialize(url)
  sandbox = Some(
    @browser.Sandbox::new(
      model,
      update,
      view,
      after_update~,
      url_request?,
      url_changed?,
    ),
  )
  sandbox.unwrap().launch(cmd)
}
