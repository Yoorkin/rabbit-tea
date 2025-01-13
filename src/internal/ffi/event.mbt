///|
type Event

///|
type EventTarget

///|
pub extern "js" fn target(self : Event) -> EventTarget =
  #| (self) => self.target

///|
pub extern "js" fn value(self : EventTarget) -> String =
  #| (self) => self.value

///|
pub extern "js" fn prevent_default(self : Event) =
  #| (self) => self.preventDefault()

///|
pub extern "js" fn stop_propagation(self : Event) =
  #| (self) => self.stopPropagation()
