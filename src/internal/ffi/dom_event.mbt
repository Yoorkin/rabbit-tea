///|
type Event

///|
pub extern "js" fn Event::to_ui_event(self : Event) -> UIEvent =
  #| (x) => x instanceof UIEvent ? x : throw new Error('not a UIEvent')

///|
type UIEvent

///|
pub extern "js" fn UIEvent::to_mouse_event(self : UIEvent) -> MouseEvent =
  #| (e) => e instanceof MouseEvent ? e : throw new Error('not a MouseEvent')

///|
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
pub extern "js" fn UIEvent::to_event(self : UIEvent) -> Event = "(x) => x"

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
