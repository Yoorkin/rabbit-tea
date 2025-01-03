///|
struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> (Command[Msg], Model)
  view : (Model) -> View
  after_update : (View, @vdom.Node) -> @vdom.Node
  attach_to : String
  mut vdom : @vdom.Node
  mut predefined : PredefinedEvent?
}

///|
pub(all) struct PredefinedEvent {
  on_url_changed : (UrlRequest) -> Unit
  on_url_request : (UrlRequest) -> Unit
}

///| Update the model and launch commands.
pub fn update[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  message : Msg
) -> Unit {
  let (cmd, model) = (self.update)(message, self.model)
  self.model = model
  let view = (self.view)(self.model)
  // update vdom and patch the result to the DOM (the patching happens in the after_update function)
  self.vdom = (self.after_update)(view, self.vdom)
  // TODO: 
  // The command may trigger another message immediately, causing the VDOM to be generated twice.
  // We need to optimize this.
  self.launch(cmd)
}

///| Refresh the view.
/// This function will call the view function and patch the result to the DOM.
pub fn refersh[Msg, Model, View](self : Sandbox[Msg, Model, View]) -> Unit {
  let view = (self.view)(self.model)
  self.vdom = (self.after_update)(view, self.vdom)
}

///|
pub fn Sandbox::new[Model, Msg, View](
  model : Model,
  update : (Msg, Model) -> (Command[Msg], Model),
  view : (Model) -> View,
  after_update~ : (View, @vdom.Node) -> @vdom.Node,
  attach_to~ : String = "app",
  url_changed? : (UrlRequest) -> Msg,
  url_request? : (UrlRequest) -> Msg
) -> Sandbox[Msg, Model, View] {
  let sandbox = {
    model,
    update,
    view,
    after_update,
    attach_to,
    predefined: None,
    vdom : @vdom.empty()
  }
  let on_url_changed = match url_changed {
    Some(f) => fn(url) { sandbox.update(f(url)) }
    None => ignore
  }
  let on_url_request = match url_request {
    Some(f) => fn(url) { sandbox.update(f(url)) }
    None => ignore
  }
  sandbox.predefined = Some({ on_url_changed, on_url_request })
  sandbox
}
