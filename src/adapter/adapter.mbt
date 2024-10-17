struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> Model
  view : (Model) -> View
  after_update : (View) -> Unit
  attach_to : String  
}

pub fn update[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  message : Msg
) -> Unit {
  self.model = (self.update)(message, self.model)
  let view = (self.view)(self.model)
  (self.after_update)(view)
}

pub fn refersh[Msg, Model, View](self : Sandbox[Msg, Model, View]) -> Unit {
  let view = (self.view)(self.model)
  (self.after_update)(view)
}

pub fn Sandbox::new[Model, Msg, View](
  model : Model,
  update : (Msg, Model) -> Model,
  view : (Model) -> View,
  ~after_update : (View) -> Unit,
  ~attach_to : String = "app"
) -> Sandbox[Msg, Model, View] {
  { model, update, view, after_update, attach_to }
}
