///|
struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> (Command[Msg], Model)
  view : (Model) -> View
  after_update : (View) -> Unit
  on_url_changed : ((@url.Url) -> Msg)?
  on_url_request : ((UrlRequest) -> Msg)?
  mut predefined : PredefinedEvent?
}

///| 
// used by vdom
pub(all) struct PredefinedEvent {
  on_url_changed : (@url.Url) -> Unit
  on_url_request : (UrlRequest) -> Unit
}

///|
// used by vdom
pub fn get_predefined_event[Msg, Model, View](
  self : Sandbox[Msg, Model, View]
) -> PredefinedEvent {
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
) -> ((UrlRequest) -> Msg)? {
  self.on_url_request
}

///| Update the model and launch commands.
pub fn update[Msg, Model, View](
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
pub fn refersh[Msg, Model, View](self : Sandbox[Msg, Model, View]) -> Unit {
  let view = (self.view)(self.model)
  (self.after_update)(view)
}

///|
pub fn Sandbox::new[Model, Msg, View](
  model : Model,
  update : (Msg, Model) -> (Command[Msg], Model),
  view : (Model) -> View,
  after_update~ : (View) -> Unit,
  url_changed? : (@url.Url) -> Msg,
  url_request? : (UrlRequest) -> Msg
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
  @ffi.window().add_event_listener("popstate", fn(_event) {
    guard let Ok(url) = @url.parse?(@ffi.window().current_url())
    on_url_changed(url)
  })
  sandbox.predefined = Some({ on_url_changed, on_url_request })
  sandbox
}
