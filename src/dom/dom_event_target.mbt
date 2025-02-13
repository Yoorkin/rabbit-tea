///|
/// # Hireharchy related to the DOM EventTarget
/// 
/// ```
/// EventTarget <-- Node <--+-- Document
///                         +-- DocumentFragment
///                         +-- Element <-- HTMLElement <--+-- HTMLCanvasElement
///                                                        +-- HTMLInputElement
/// ```
type EventTarget

///|
pub extern "js" fn to_node(self : EventTarget) -> @js.Nullable[Node] =
  #| (x) => x instanceof Node ? x : null

///|
pub extern "js" fn add_event_listener(
  self : EventTarget,
  type_ : String,
  callback : Listener
) -> Unit =
  #| (target, type, listener) => target.addEventListener(type, listener)

///|
pub extern "js" fn remove_event_listener(
  self : EventTarget,
  type_ : String,
  callback : Listener
) -> Unit =
  #| (target, type, listener) => target.removeEventListener(type, listener)

///|
pub extern "js" fn dispatch_event(self : EventTarget, event : Event) -> Unit =
  #| (target, event) => target.dispatchEvent(event)

///|
pub typealias Listener = (Event) -> Unit
