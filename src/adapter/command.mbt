pub enum Command[M] {
  Custom(((M) -> Unit) -> Unit)
  Message(M)
  Batch(Array[Command[M]])
  None
}

fn launch[M](self : Command[M], update : (M) -> Unit) -> Unit {
  match self {
    Custom(f) => f(update)
    Message(msg) => update(msg)
    Batch(cmds) =>
      for cmd in cmds {
        cmd.launch(update)
      }
    None => ()
  }
}

pub fn map[A, B](self : Command[A], f : (A) -> B) -> Command[B] {
  match self {
    Custom(g) => Custom(fn(h) { g(fn(x) { h(f(x)) }) })
    Message(msg) => Message(f(msg))
    Batch(xs) => Batch(xs.map(fn(x) { x.map(f) }))
    None => None
  }
}
