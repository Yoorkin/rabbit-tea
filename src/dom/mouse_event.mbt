///|
#external
type MouseEvent

///|
pub extern "js" fn MouseEvent::screen_x(self : Self) -> Int = "(e) => e.screenX"

///|
pub extern "js" fn MouseEvent::screen_y(self : Self) -> Int = "(e) => e.screenY"

///|
pub extern "js" fn MouseEvent::client_x(self : Self) -> Int = "(e) => e.clientX"

///|
pub extern "js" fn MouseEvent::client_y(self : Self) -> Int = "(e) => e.clientY"

///|
pub extern "js" fn MouseEvent::offset_x(self : Self) -> Int = "(e) => e.offsetX"

///|
pub extern "js" fn MouseEvent::offset_y(self : Self) -> Int = "(e) => e.offsetY"

///|
pub extern "js" fn MouseEvent::ctrl_key(self : Self) -> Bool = "(e) => e.ctrlKey"

///|
pub extern "js" fn MouseEvent::shift_key(self : Self) -> Bool = "(e) => e.shiftKey"

///|
pub extern "js" fn MouseEvent::alt_key(self : Self) -> Bool = "(e) => e.altKey"

///|
pub extern "js" fn MouseEvent::meta_key(self : Self) -> Bool = "(e) => e.metaKey"
