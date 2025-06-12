///|
pub typealias @cmd.(Cmd, Command)

///|
pub fnalias @cmd.(none, batch, task, perform, attempt)

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
pub fn[Model, Message] startup(
  model~ : Model,
  update~ : (Message, Model) -> (Cmd[Message], Model),
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
    guard sandbox is Some(sandbox)
    let new_dom = html.to_virtual_dom()
    new_dom.patch(curr_dom, sandbox, mount~)
    curr_dom = new_dom
  }

  sandbox = Some(@browser.Sandbox::new(model, update, view, after_update~))
  sandbox.unwrap().refresh()
}

///| Start the application with initial URL. 
/// 
/// - `url_changed` is a message that will be passed when the URL is changed by the navigation API in the `@browser` package.
/// - `url_request` is a message that will be passed when an `<a>` tag is clicked.
/// - `initialize` will be called when the application is started. 
/// 
pub fn[Model, Msg] application(
  initialize~ : (@url.Url) -> (Cmd[Msg], Model),
  update~ : (Msg, Model) -> (Cmd[Msg], Model),
  view~ : (Model) -> @html.Html[Msg],
  url_changed? : (@url.Url) -> Msg,
  url_request? : (@url.UrlRequest) -> Msg,
  mount~ : String = "app"
) -> Unit {
  @dom.document()
  .get_element_by_id(mount)
  .get_exn()
  .set_inner_html("<div></div>")
  let mut sandbox_ref = None
  let mut curr_dom = @vdom.node("div", [], [])
  fn after_update(html : @html.Html[Msg]) {
    guard sandbox_ref is Some(sandbox)
    let new_dom = html.to_virtual_dom()
    new_dom.patch(curr_dom, sandbox, mount~)
    curr_dom = new_dom
  }

  guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
  let (cmd, model) = initialize(url)
  let sandbox = @browser.Sandbox::new(
    model,
    update,
    view,
    after_update~,
    url_request?,
    url_changed?,
  )
  sandbox_ref = Some(sandbox)
  sandbox..launch(cmd)..refresh()
}
