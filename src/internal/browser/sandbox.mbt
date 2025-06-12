///|
struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> (@cmd.Cmd[Msg], Model)
  view : (Model) -> View
  after_update : (View) -> Unit
  on_url_changed : ((@url.Url) -> Msg)?
  on_url_request : ((@url.UrlRequest) -> Msg)?
  mut predefined : @cmd.Events[Msg]?
}

///|
// used by vdom
pub fn[Msg, Model, View] get_predefined_events(
  self : Sandbox[Msg, Model, View]
) -> @cmd.Events[Msg] {
  self.predefined.unwrap()
}

///|
// used by vdom
pub fn[Msg, Model, View] get_on_url_changed(
  self : Sandbox[Msg, Model, View]
) -> ((@url.Url) -> Msg)? {
  self.on_url_changed
}

///|
pub fn[Msg, Model, View] get_on_url_request(
  self : Sandbox[Msg, Model, View]
) -> ((@url.UrlRequest) -> Msg)? {
  self.on_url_request
}

///| Update the model and launch commands.
pub fn[Msg, Model, View] update(
  self : Sandbox[Msg, Model, View],
  message : Msg
) -> Unit {
  let (cmd, model) = (self.update)(message, self.model)
  self.model = model
  let view = (self.view)(self.model)
  (self.after_update)(view)
  // TODO: 
  // The command may trigger another message immediately, causing the VDOM to be generated twice.
  // We need to optimize this.
  self.launch(cmd)
}

///| Refresh the view.
/// This function will call the view function and patch the result to the DOM.
pub fn[Msg, Model, View] refresh(self : Sandbox[Msg, Model, View]) -> Unit {
  let view = (self.view)(self.model)
  (self.after_update)(view)
}

///|
pub fn[Model, Msg, View] Sandbox::new(
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
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    on_url_changed(url)
  })
  sandbox.predefined = Some(
    @cmd.Events::new(on_url_changed, on_url_request, fn(msg) {
      sandbox.update(msg)
    }),
  )
  sandbox
}
