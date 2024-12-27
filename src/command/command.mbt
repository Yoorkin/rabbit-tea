///| A command that sent to the runtime.
pub(all) enum T[M] {
  Custom(((M) -> Unit) -> Unit)
  Message(M)
  Batch(Array[T[M]])
  None
}

///| Map the messages in the command to another type.
pub fn map[A, B](self : T[A], f : (A) -> B) -> T[B] {
  match self {
    Custom(g) => Custom(fn(h) { g(fn(x) { h(f(x)) }) })
    Message(msg) => Message(f(msg))
    Batch(xs) => Batch(xs.map(fn(x) { x.map(f) }))
    None => None
  }
}
