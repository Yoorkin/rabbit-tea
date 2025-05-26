///| Launch commands. It may trigger the update function.
pub fn[M, Model, View] launch(
  self : Sandbox[M, Model, View],
  cmd : @cmd.Cmd[M]
) -> Unit {
  let f = cmd._
  f(self.predefined.unwrap())
}
