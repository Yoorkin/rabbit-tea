///| 
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

///| Create a command that does nothing.
pub fn none[M]() -> Cmd[M] {
  Cmd(fn { _, _ => () })
}

///| Create a command that runs multiple commands.
pub fn batch[M](xs : Array[Cmd[M]]) -> Cmd[M] {
  Cmd(fn(predef, update) { xs.each(fn { Cmd(f) => f(predef, update) }) })
}

///| Create a command that trigger another update for the given message.
pub fn task[M](message : M) -> Cmd[M] {
  Cmd(fn(_, update) { update(message) })
}

///| Create a command that runs an async function.
/// 
/// The async function `f` will be called, and the result will be wrapped in a 
/// message `msg`, then trigger another update with this message.
pub fn perform[A, M](msg : (A) -> M, f : async () -> A) -> Cmd[M] {
  Cmd(fn(_, update) { @js.async_run(fn() { update(msg(f!!())) }) })
}

///| Create a command that runs an async function and handles errors.
/// 
/// This is similar to `perform`, but it converts the returned value 
/// or thrown error into a `Result`.
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
