pub enum Command[M] {
  Custom(((M) -> Unit) -> Unit)
  Batch(Array[Command[M]])
  None
}

fn launch[M](self : Command[M], update : (M) -> Unit) -> Unit {
  match self {
    Custom(f) => f(update)
    Batch(cmds) =>
      for cmd in cmds {
        cmd.launch(update)
      }
    None => ()
  }
}
