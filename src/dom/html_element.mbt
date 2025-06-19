///|
#external
type HTMLElement

///|
pub extern "js" fn HTMLElement::to_element(self : Self) -> Element = "(x) => x"

///|
pub extern "js" fn HTMLElement::to_html_canvas_element(
  self : Self
) -> @js.Nullable[HTMLCanvasElement] =
  #| (x) => x instanceof HTMLCanvasElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_input_element(
  self : Self
) -> @js.Nullable[HTMLInputElement] =
  #| (x) => x instanceof HTMLInputElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_select_element(
  self : Self
) -> @js.Nullable[HTMLSelectElement] =
  #| (x) => x instanceof HTMLSelectElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_dialog_element(
  self : Self
) -> @js.Nullable[HTMLDialogElement] =
  #| (x) => x instanceof HTMLDialogElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_image_element(
  self : Self
) -> @js.Nullable[HTMLImageElement] =
  #| (x) => x instanceof HTMLImageElement ? x : null

///|
pub extern "js" fn HTMLElement::set_style(
  self : Self,
  key : String,
  value : String
) -> Unit =
  #| (self,key,value) => self.style[key] = value

///|
pub extern "js" fn HTMLElement::remove_style(self : Self, key : String) =
  #| (self,key) => self.style[key] = ''
