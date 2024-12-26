///|
struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> (Command[Msg], Model)
  view : (Model) -> View
  after_update : (View) -> Unit
  attach_to : String
}

///|
pub fn update[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  message : Msg
) -> Unit {
  let (cmd, model) = (self.update)(message, self.model)
  self.model = model
  cmd.launch(fn(msg) { self.update(msg) })
  let view = (self.view)(self.model)
  (self.after_update)(view)
}

///|
pub fn refersh[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  init_msg : Msg?
) -> Unit {
  let view = (self.view)(self.model)
  (self.after_update)(view)
  match init_msg {
    None => ()
    Some(msg) => self.update(msg)
  }
}

///|
pub fn Sandbox::new[Model, Msg, View](
  model : Model,
  update : (Msg, Model) -> (Command[Msg], Model),
  view : (Model) -> View,
  after_update~ : (View) -> Unit,
  attach_to~ : String = "app"
) -> Sandbox[Msg, Model, View] {
  { model, update, view, after_update, attach_to }
}
