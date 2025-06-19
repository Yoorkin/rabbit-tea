///|
#external
type InputEvent

///|
pub extern "js" fn InputEvent::data(self : Self) -> String = "(e) => e.data"

///|
pub extern "js" fn InputEvent::is_composing(self : Self) -> Bool = "(e) => e.isComposing"

///|
pub extern "js" fn InputEvent::input_type(self : Self) -> String = "(e) => e.inputType"
