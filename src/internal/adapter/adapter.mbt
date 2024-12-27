///|
struct Sandbox[Msg, Model, View] {
  mut model : Model
  update : (Msg, Model) -> (Command[Msg], Model)
  view : (Model) -> View
  after_update : (View) -> Unit
  attach_to : String
}

///| Launch commands. It may trigger the update function.
fn launch_cmd[M](cmd : @command.T[M], update : (M) -> Unit) -> Unit {
  match cmd {
    Custom(f) => f(update)
    Message(msg) => update(msg)
    Batch(cmds) =>
      for cmd in cmds {
        launch_cmd(cmd, update)
      }
    None => ()
  }
}

///| Update the model and launch commands.
pub fn update[Msg, Model, View](
  self : Sandbox[Msg, Model, View],
  message : Msg
) -> Unit {
  let (cmd, model) = (self.update)(message, self.model)
  self.model = model
  launch_cmd(cmd, fn(msg) { self.update(msg) })
  let view = (self.view)(self.model)
  (self.after_update)(view)
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
  attach_to~ : String = "app"
) -> Sandbox[Msg, Model, View] {
  { model, update, view, after_update, attach_to }
}
