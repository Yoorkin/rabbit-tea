///|
struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> (@cmd.Cmd[Msg], Model)
  view : (Model) -> View
  after_update : (View) -> Unit
  on_url_changed : ((@url.Url) -> Msg)?
  on_url_request : ((@url.UrlRequest) -> Msg)?
  mut predefined : @cmd.Events[Msg]?
  mut dev_tool : @devtool.DevTool?
}

///|
pub fn set_devtool[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  dev_tool : @devtool.DevTool
) -> Unit {
  self.dev_tool = Some(dev_tool)
}

pub fn set_model[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  model : Model
) -> Unit {
  self.model = model
}

///|
// used by vdom
pub fn get_predefined_events[Msg, Model, View](
  self : Sandbox[Msg, Model, View]
) -> @cmd.Events[Msg] {
  self.predefined.unwrap()
}

///|
// used by vdom
pub fn get_on_url_changed[Msg, Model, View](
  self : Sandbox[Msg, Model, View]
) -> ((@url.Url) -> Msg)? {
  self.on_url_changed
}

///|
pub fn get_on_url_request[Msg, Model, View](
  self : Sandbox[Msg, Model, View]
) -> ((@url.UrlRequest) -> Msg)? {
  self.on_url_request
}

///| Update the model and launch commands.
pub fn update[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  message : Msg
) -> Unit {
  let (cmd, model) = (self.update)(message, self.model)
  self.model = model
  if self.dev_tool is Some(dev_tool) {
    dev_tool.send(message, model)
  }
  let view = (self.view)(self.model)
  (self.after_update)(view)
  // TODO: 
  // The command may trigger another message immediately, causing the VDOM to be generated twice.
  // We need to optimize this.
  self.launch(cmd)
}

///| Refresh the view.
/// This function will call the view function and patch the result to the DOM.
pub fn refersh[Msg, Model, View](self : Sandbox[Msg, Model, View]) -> Unit {
  let view = (self.view)(self.model)
  (self.after_update)(view)
}

///|
pub fn Sandbox::new[Model, Msg, View](
  model : Model,
  update : (Msg, Model) -> (@cmd.Cmd[Msg], Model),
  view : (Model) -> View,
  after_update~ : (View) -> Unit,
  url_changed? : (@url.Url) -> Msg,
  url_request? : (@url.UrlRequest) -> Msg
) -> Sandbox[Msg, Model, View] {
  let sandbox = {
    model,
    update,
    view,
    after_update,
    on_url_changed: url_changed,
    on_url_request: url_request,
    predefined: None,
    dev_tool: None,
  }
  let on_url_changed = match url_changed {
    Some(f) => fn(url) { sandbox.update(f(url)) }
    None => ignore
  }
  let on_url_request = match url_request {
    Some(f) => fn(url) { sandbox.update(f(url)) }
    None => ignore
  }
  @dom.window()
  .to_event_target()
  .add_event_listener("popstate", fn(_event) {
    guard @url.parse?(@dom.window().current_url()) is Ok(url)
    on_url_changed(url)
  })
  sandbox.predefined = Some(
    @cmd.Events::new(on_url_changed, on_url_request, fn(msg) {
      sandbox.update(msg)
    }),
  )
  sandbox
}
