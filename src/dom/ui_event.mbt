///|
#external
type UIEvent

///|
pub extern "js" fn UIEvent::to_event(self : Self) -> Event = "(x) => x"

///|
pub extern "js" fn UIEvent::to_mouse_event(
  self : Self
) -> @js.Nullable[MouseEvent] =
  #| (e) => e instanceof MouseEvent ? e : null

///|
pub extern "js" fn UIEvent::to_input_event(
  self : Self
) -> @js.Nullable[MouseEvent] =
  #| (e) => e instanceof InputEvent ? e : null

///|
pub extern "js" fn UIEvent::to_focus_event(
  self : Self
) -> @js.Nullable[MouseEvent] =
  #| (e) => e instanceof FocusEvent ? e : null

///|
pub extern "js" fn UIEvent::to_keyboard_event(
  self : Self
) -> @js.Nullable[KeyboardEvent] =
  #| (e) => e instanceof KeyboardEvent ? e : null
