///|
pub(all) type Command[M] (PredefinedEvent, (M) -> Unit) -> Unit

///| Map the messages in the command to another type.
pub fn map[A, B](self : Command[A], f : (A) -> B) -> Command[B] {
  Command(fn(predef, update) {
    let update = fn(msg) { update(f(msg)) }
    guard let Command(f) = self
    f(predef, update)
  })
}

///| Launch commands. It may trigger the update function.
pub fn launch[M, Model, View](
  self : Sandbox[M, Model, View],
  cmd : Command[M]
) -> Unit {
  let f = cmd._
  let update = fn(m) { self.update(m) }
  f(self.predefined.unwrap(), update)
}

///|
pub fn none[M]() -> Command[M] {
  Command(fn { _, _ => () })
}

///|
pub fn batch[M](xs : Array[Command[M]]) -> Command[M] {
  Command(fn(predef, update) { xs.each(fn { Command(f) => f(predef, update) }) })
}

///|
pub fn task[M](message : M) -> Command[M] {
  Command(fn(predef, update) { update(message) })
}
