///| Store the events that can be triggered by the command.
struct Events[M] {
  on_url_changed : (@url.Url) -> Unit
  on_url_request : (@url.UrlRequest) -> Unit
  on_update : (M) -> Unit
}

///| Used by the runtime.
pub fn[M] Events::new(
  on_url_changed : (@url.Url) -> Unit,
  on_url_request : (@url.UrlRequest) -> Unit,
  on_update : (M) -> Unit
) -> Events[M] {
  { on_url_changed, on_url_request, on_update }
}

///| Trigger the update function with `url_changed` message config by the user.
pub fn[M] Events::trigger_url_changed(self : Events[M], url : @url.Url) -> Unit {
  (self.on_url_changed)(url)
}

///| Trigger the update function with `url_request` message config by the user.
pub fn[M] Events::trigger_url_request(
  self : Events[M],
  url : @url.UrlRequest
) -> Unit {
  (self.on_url_request)(url)
}

///| Trigger the update function with message `msg`.
pub fn[M] Events::trigger_update(self : Events[M], msg : M) -> Unit {
  (self.on_update)(msg)
}

///| The command type, represents a task that can be executed.
/// 
/// You can define your own command to interoperate Rabbit-Tea with the outside JS world.
/// 
/// Before implementing your own command, check the existing commands in the `nav` and `http` packages.
/// 
/// # Example 
/// 
/// ```
/// fn delay[M](msg : M, ms : Int) -> Cmd[M] {
///   Cmd(fn(events){
///     set_timeout(fn(){ events.trigger_update(msg) }, ms)
///   })
/// } 
/// 
/// extern "js" fn set_timeout(f : () -> Unit, ms : Int) = "(f,ms) => setTimeout(f, ms)"
/// ```
pub(all) type Cmd[M] (Events[M]) -> Unit

///|
pub typealias Command[M] = Cmd[M]

///| Map the messages in the command to another type.
pub fn[A, B] map(self : Cmd[A], f : (A) -> B) -> Cmd[B] {
  Cmd(fn(events) {
    let predef = {
      on_url_changed: events.on_url_changed,
      on_url_request: events.on_url_request,
      on_update: fn(msg) { (events.on_update)(f(msg)) },
    }
    let Cmd(f) = self
    f(predef)
  })
}

///| Create a command that does nothing.
pub fn[M] none() -> Cmd[M] {
  Cmd(fn { _ => () })
}

///| Create a command that runs multiple commands.
pub fn[M] batch(xs : Array[Cmd[M]]) -> Cmd[M] {
  Cmd(fn(events) { xs.each(fn { Cmd(f) => f(events) }) })
}

///| Create a command that trigger another update for the given message.
pub fn[M] task(message : M) -> Cmd[M] {
  Cmd(fn(events) { events.trigger_update(message) })
}

///| Create a command that runs an async function.
/// 
/// The async function `f` will be called, and the result will be wrapped in a 
/// message `msg`, then trigger another update with this message.
pub fn[A, M] perform(msg : (A) -> M, f : () -> A!Async) -> Cmd[M] {
  Cmd(fn(events) { @js.async_run(fn() { events.trigger_update(msg(f!())) }) })
}

///| Create a command that runs an async function and handles errors.
/// 
/// This is similar to `perform`, but it converts the returned value 
/// or thrown error into a `Result`.
pub fn[A, E : Error, M] attempt(
  msg : (Result[A, E]) -> M,
  f : () -> A!Async + E
) -> Cmd[M] {
  Cmd(fn(events) {
    @js.async_run(fn() {
      let msg = try f!() catch {
        e => msg(Err(e))
      } else {
        r => msg(Ok(r))
      }
      events.trigger_update(msg)
    })
  })
}
