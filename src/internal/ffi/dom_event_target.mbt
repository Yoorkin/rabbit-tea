///|
type EventTarget

///|
pub typealias Listener = (Event) -> Unit

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
