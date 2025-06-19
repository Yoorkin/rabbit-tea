///|
#external
type FocusEvent

///|
pub extern "js" fn FocusEvent::related_target(self : Self) -> EventTarget = "(e) => e.relatedTarget"
