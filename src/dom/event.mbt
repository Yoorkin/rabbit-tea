///|
#external
type Event

///|
pub extern "js" fn Event::target(self : Self) -> EventTarget = "(self) => self.target"

///|
pub extern "js" fn Event::to_ui_event(self : Self) -> @js.Nullable[UIEvent] =
  #| (x) => x instanceof UIEvent ? x : null

///|
pub extern "js" fn Event::to_clipboard_event(
  self : Self
) -> @js.Nullable[KeyboardEvent] =
  #| (x) => x instanceof ClipboardEvent ? x : null

///|
pub extern "js" fn Event::prevent_default(self : Self) = "(self) => self.preventDefault()"

///|
pub extern "js" fn Event::stop_propagation(self : Self) = "(self) => self.stopPropagation()"
