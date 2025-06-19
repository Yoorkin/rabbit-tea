///|
#external
type EventTarget

///|
pub extern "js" fn EventTarget::to_node(self : Self) -> @js.Nullable[Node] =
  #| (x) => x instanceof Node ? x : null

///|
pub extern "js" fn EventTarget::to_clipboard(
  self : Self
) -> @js.Nullable[Clipboard] =
  #| (x) => x instanceof Clipboard ? x : null

///|
pub extern "js" fn EventTarget::add_event_listener(
  self : Self,
  type_ : String,
  callback : Listener
) -> Unit =
  #| (target, type, listener) => target.addEventListener(type, listener)

///|
pub extern "js" fn EventTarget::remove_event_listener(
  self : Self,
  type_ : String,
  callback : Listener
) -> Unit =
  #| (target, type, listener) => target.removeEventListener(type, listener)

///|
pub extern "js" fn EventTarget::dispatch_event(
  self : Self,
  event : Event
) -> Unit =
  #| (target, event) => target.dispatchEvent(event)

///|
pub typealias (Event) -> Unit as Listener
