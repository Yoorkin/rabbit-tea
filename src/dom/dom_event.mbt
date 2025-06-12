///|
/// 
/// # Hierarchy of DOM Events
/// 
/// ```
/// Event <-+-- ClipboardEvent
///         +-- UIEvent <--+-- MouseEvent
///                        +-- InputEvent
///                        +-- FocusEvent
///                        +-- KeyboardEvent
/// ```
#external
type Event

///|
pub extern "js" fn Event::target(self : Event) -> EventTarget = "(self) => self.target"

///|
pub extern "js" fn Event::to_ui_event(self : Event) -> @js.Nullable[UIEvent] =
  #| (x) => x instanceof UIEvent ? x : null

///|
pub extern "js" fn Event::to_clipboard_event(
  self : Event
) -> @js.Nullable[KeyboardEvent] =
  #| (x) => x instanceof ClipboardEvent ? x : null

///|
pub extern "js" fn Event::prevent_default(self : Event) = "(self) => self.preventDefault()"

///|
pub extern "js" fn Event::stop_propagation(self : Event) = "(self) => self.stopPropagation()"

///|
#external
type UIEvent

///|
pub extern "js" fn UIEvent::to_event(self : UIEvent) -> Event = "(x) => x"

///|
pub extern "js" fn UIEvent::to_mouse_event(
  self : UIEvent
) -> @js.Nullable[MouseEvent] =
  #| (e) => e instanceof MouseEvent ? e : null

///|
pub extern "js" fn UIEvent::to_input_event(
  self : UIEvent
) -> @js.Nullable[MouseEvent] =
  #| (e) => e instanceof InputEvent ? e : null

///|
pub extern "js" fn UIEvent::to_focus_event(
  self : UIEvent
) -> @js.Nullable[MouseEvent] =
  #| (e) => e instanceof FocusEvent ? e : null

///|
pub extern "js" fn UIEvent::to_keyboard_event(
  self : UIEvent
) -> @js.Nullable[KeyboardEvent] =
  #| (e) => e instanceof KeyboardEvent ? e : null

///|
#external
type MouseEvent

///|
pub extern "js" fn MouseEvent::screen_x(self : MouseEvent) -> Int = "(e) => e.screenX"

///|
pub extern "js" fn MouseEvent::screen_y(self : MouseEvent) -> Int = "(e) => e.screenY"

///|
pub extern "js" fn MouseEvent::client_x(self : MouseEvent) -> Int = "(e) => e.clientX"

///|
pub extern "js" fn MouseEvent::client_y(self : MouseEvent) -> Int = "(e) => e.clientY"

///|
pub extern "js" fn MouseEvent::offset_x(self : MouseEvent) -> Int = "(e) => e.offsetX"

///|
pub extern "js" fn MouseEvent::offset_y(self : MouseEvent) -> Int = "(e) => e.offsetY"

///|
pub extern "js" fn MouseEvent::ctrl_key(self : MouseEvent) -> Bool = "(e) => e.ctrlKey"

///|
pub extern "js" fn MouseEvent::shift_key(self : MouseEvent) -> Bool = "(e) => e.shiftKey"

///|
pub extern "js" fn MouseEvent::alt_key(self : MouseEvent) -> Bool = "(e) => e.altKey"

///|
pub extern "js" fn MouseEvent::meta_key(self : MouseEvent) -> Bool = "(e) => e.metaKey"

///|
#external
type InputEvent

///|
pub extern "js" fn InputEvent::data(self : InputEvent) -> String = "(e) => e.data"

///|
pub extern "js" fn InputEvent::is_composing(self : InputEvent) -> Bool = "(e) => e.isComposing"

///|
pub extern "js" fn InputEvent::input_type(self : InputEvent) -> String = "(e) => e.inputType"

///|
#external
type FocusEvent

///|
pub extern "js" fn FocusEvent::related_target(self : FocusEvent) -> EventTarget = "(e) => e.relatedTarget"

///|
#external
type KeyboardEvent

///|
pub extern "js" fn KeyboardEvent::key(self : KeyboardEvent) -> String = "(e) => e.key"

///|
pub extern "js" fn KeyboardEvent::code(self : KeyboardEvent) -> String = "(e) => e.code"

///|
pub extern "js" fn KeyboardEvent::alt_key(self : KeyboardEvent) -> Bool = "(e) => e.altKey"

///|
pub extern "js" fn KeyboardEvent::ctrl_key(self : KeyboardEvent) -> Bool = "(e) => e.ctrlKey"

///|
pub extern "js" fn KeyboardEvent::shift_key(self : KeyboardEvent) -> Bool = "(e) => e.shiftKey"

///|
pub extern "js" fn KeyboardEvent::meta_key(self : KeyboardEvent) -> Bool = "(e) => e.metaKey"

///|
pub extern "js" fn KeyboardEvent::is_composing(self : KeyboardEvent) -> Bool = "(e) => e.isComposing"

///|
pub extern "js" fn KeyboardEvent::repeat(self : KeyboardEvent) -> Bool = "(e) => e.repeat"

///|
pub extern "js" fn KeyboardEvent::location(self : KeyboardEvent) -> Int = "(e) => e.location"

///|
pub const DOM_KEY_LOCATION_STANDARD : Int = 0x00

///|
pub const DOM_KEY_LOCATION_LEFT : Int = 0x01

///|
pub const DOM_KEY_LOCATION_RIGHT : Int = 0x02

///|
pub const DOM_KEY_LOCATION_NUMPAD : Int = 0x03

///|
#external
type ClipboardEvent

///|
pub extern "js" fn ClipboardEvent::clipboard_data(
  self : ClipboardEvent
) -> DataTransfer = "(e) => e.clipboardData"
