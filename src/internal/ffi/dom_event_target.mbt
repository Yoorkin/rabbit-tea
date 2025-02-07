///|
type EventTarget

///|
type Event

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

///|
pub extern "js" fn target(self : Event) -> EventTarget = "(self) => self.target"

///|
pub extern "js" fn value(self : EventTarget) -> String = "(self) => self.value"

///|
pub extern "js" fn prevent_default(self : Event) = "(self) => self.preventDefault()"

///|
pub extern "js" fn stop_propagation(self : Event) = "(self) => self.stopPropagation()"

///|
pub extern "js" fn client_x(self : Event) -> Int = "(self) => self.clientX"

///|
pub extern "js" fn client_y(self : Event) -> Int = "(self) => self.clientY"

///|
pub extern "js" fn screen_x(self : Event) -> Int = "(self) => self.screenX"

///|
pub extern "js" fn screen_y(self : Event) -> Int = "(self) => self.screenY"

///|
pub extern "js" fn offset_x(self : Event) -> Int = "(self) => self.offsetX"

///|
pub extern "js" fn offset_y(self : Event) -> Int = "(self) => self.offsetY"
