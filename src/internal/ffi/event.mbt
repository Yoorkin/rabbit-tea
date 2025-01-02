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
