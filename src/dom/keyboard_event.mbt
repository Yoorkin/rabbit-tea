///|
#external
type KeyboardEvent

///|
pub extern "js" fn KeyboardEvent::key(self : Self) -> String = "(e) => e.key"

///|
pub extern "js" fn KeyboardEvent::code(self : Self) -> String = "(e) => e.code"

///|
pub extern "js" fn KeyboardEvent::alt_key(self : Self) -> Bool = "(e) => e.altKey"

///|
pub extern "js" fn KeyboardEvent::ctrl_key(self : Self) -> Bool = "(e) => e.ctrlKey"

///|
pub extern "js" fn KeyboardEvent::shift_key(self : Self) -> Bool = "(e) => e.shiftKey"

///|
pub extern "js" fn KeyboardEvent::meta_key(self : Self) -> Bool = "(e) => e.metaKey"

///|
pub extern "js" fn KeyboardEvent::is_composing(self : Self) -> Bool = "(e) => e.isComposing"

///|
pub extern "js" fn KeyboardEvent::repeat(self : Self) -> Bool = "(e) => e.repeat"

///|
pub extern "js" fn KeyboardEvent::location(self : Self) -> Int = "(e) => e.location"

///|
pub const DOM_KEY_LOCATION_STANDARD : Int = 0x00

///|
pub const DOM_KEY_LOCATION_LEFT : Int = 0x01

///|
pub const DOM_KEY_LOCATION_RIGHT : Int = 0x02

///|
pub const DOM_KEY_LOCATION_NUMPAD : Int = 0x03
