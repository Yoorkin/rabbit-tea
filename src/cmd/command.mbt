///| 
// used by vdom
pub(all) struct PredefinedEvent {
  on_url_changed : (@url.Url) -> Unit
  on_url_request : (@url.UrlRequest) -> Unit
}

///|
pub(all) type Cmd[M] (PredefinedEvent, (M) -> Unit) -> Unit

///|
pub typealias Command[M] = Cmd[M]

///| Map the messages in the command to another type.
pub fn map[A, B](self : Cmd[A], f : (A) -> B) -> Cmd[B] {
  Cmd(fn(predef, update) {
    let update = fn(msg) { update(f(msg)) }
    let Cmd(f) = self
    f(predef, update)
  })
}

///|
pub fn none[M]() -> Cmd[M] {
  Cmd(fn { _, _ => () })
}

///|
pub fn batch[M](xs : Array[Cmd[M]]) -> Cmd[M] {
  Cmd(fn(predef, update) { xs.each(fn { Cmd(f) => f(predef, update) }) })
}

///|
pub fn task[M](message : M) -> Cmd[M] {
  Cmd(fn(_, update) { update(message) })
}

///|
pub fn perform[A, M](msg : (A) -> M, f : async () -> A) -> Cmd[M] {
  Cmd(fn(_, update) { @js.async_run(fn() { update(msg(f!!())) }) })
}

///|
pub fn attempt[A, E : Error, M](
  msg : (Result[A, E]) -> M,
  f : async () -> A!E
) -> Cmd[M] {
  Cmd(fn(_, update) {
    @js.async_run(fn() {
      let msg = try {
        f!!()
      } catch {
        e => msg(Err(e))
      } else {
        r => msg(Ok(r))
      }
      update(msg)
    })
  })
}
