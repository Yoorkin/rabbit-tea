///| Launch commands. It may trigger the update function.
pub fn launch[M, Model, View](
  self : Sandbox[M, Model, View],
  cmd : @cmd.Cmd[M]
) -> Unit {
  let f = cmd._
  let update = fn(m) { self.update(m) }
  f(self.predefined.unwrap(), update)
}
