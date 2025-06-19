///|
#external
type Element

///|
pub extern "js" fn Element::to_html_element(
  self : Element
) -> @js.Nullable[HTMLElement] =
  #| (x) => x instanceof HTMLElement ? x : null

///|
pub extern "js" fn Element::children(self : Element) -> Array[Element] =
  #| (self) => self.children

///|
pub extern "js" fn Element::append_children(
  self : Element,
  child : Element
) -> Unit = "(self, child) => self.append(child)"

///|
pub extern "js" fn Element::remove_children(
  self : Element,
  child : Element
) -> Unit = " (self,child) => self.remove(child) "

// NOTE: The DOM tree also includes the TEXT_NODE, which is not an element.
// Therefore, a vdom patch algorithm should not be based on the ffi above.
// https://dom.spec.whatwg.org/#ref-for-dom-node-nodetype%E2%91%A0

///|
pub extern "js" fn Element::set_attribute(
  self : Element,
  attr : String,
  value : String
) -> Unit = "(self,attr,value) => self.setAttribute(attr, value)"

///|
pub extern "js" fn Element::get_attribute(
  self : Element,
  attr : String
) -> String = "(self,attr) => self.getAttribute(attr)"

///|
pub extern "js" fn Element::remove_attribute(
  self : Element,
  attr : String
) -> Unit = "(self,attr) => self.removeAttribute(attr)"

///| 
pub extern "js" fn Element::set_property(
  self : Element,
  prop : String,
  value : @js.Value
) = "(self,prop,value) => self[prop] = value"

///|
pub extern "js" fn Element::remove_property(
  self : Element,
  prop : String
) -> Unit = "(self,prop) => delete self[prop]"

///|
pub extern "js" fn Element::get_property(
  self : Element,
  prop : String
) -> String = "(self,prop) => self[prop]"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView
pub extern "js" fn Element::scroll_into_view(self : Element) = "(self) => self.scrollIntoView()"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTop
pub extern "js" fn Element::get_scroll_top(self : Self) -> Double = "(self) => self.scrollTop"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTop
pub extern "js" fn Element::set_scroll_top(self : Self, value : Double) = "(s,v) => s.scrollTop = v"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeft
pub extern "js" fn Element::get_scroll_left(self : Self) -> Double = "(self) => self.scrollLeft"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeft
pub extern "js" fn Element::set_scroll_left(self : Self, value : Double) = "(s,v) => s.scrollLeft = v"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollWidth
pub extern "js" fn Element::get_scroll_width(self : Self) -> Double = "(self) => self.scrollWidth"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight
pub extern "js" fn Element::get_scroll_height(self : Self) -> Double = "(self) => self.scrollHeight"

///|
pub extern "js" fn Element::set_inner_html(
  self : Element,
  html : String
) -> Unit = "(self,html) => self.innerHTML = html"

///|
pub extern "js" fn Element::get_bounding_client_rect(self : Element) -> DOMRect =
  #| (self) => self.getBoundingClientRect()

///|
#external
type HTMLElement

///|
pub extern "js" fn HTMLElement::to_element(self : HTMLElement) -> Element = "(x) => x"

///|
pub extern "js" fn HTMLElement::to_html_canvas_element(
  self : HTMLElement
) -> @js.Nullable[HTMLCanvasElement] =
  #| (x) => x instanceof HTMLCanvasElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_input_element(
  self : HTMLElement
) -> @js.Nullable[HTMLInputElement] =
  #| (x) => x instanceof HTMLInputElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_select_element(
  self : HTMLElement
) -> @js.Nullable[HTMLSelectElement] =
  #| (x) => x instanceof HTMLSelectElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_dialog_element(
  self : HTMLElement
) -> @js.Nullable[HTMLDialogElement] =
  #| (x) => x instanceof HTMLDialogElement ? x : null

///|
pub extern "js" fn HTMLElement::to_html_image_element(
  self : Self
) -> @js.Nullable[HTMLImageElement] =
  #| (x) => x instanceof HTMLImageElement ? x : null

///|
pub extern "js" fn HTMLElement::set_style(
  self : HTMLElement,
  key : String,
  value : String
) -> Unit =
  #| (self,key,value) => self.style[key] = value

///|
pub extern "js" fn HTMLElement::remove_style(self : HTMLElement, key : String) =
  #| (self,key) => self.style[key] = ''

///|
#external
type HTMLInputElement

///|
pub extern "js" fn HTMLInputElement::value(self : HTMLInputElement) -> String = "(self) => self.value"

///|
#external
type HTMLSelectElement

///|
pub extern "js" fn HTMLSelectElement::value(self : HTMLSelectElement) -> String = "(self) => self.value"

///|
#external
type HTMLDialogElement

///|
pub extern "js" fn HTMLDialogElement::open(self : HTMLDialogElement) -> Bool = "(self) => self.open"

///|
pub extern "js" fn HTMLDialogElement::return_value(
  self : HTMLDialogElement
) -> String = "(self) => self.returnValue"

///|
pub extern "js" fn HTMLDialogElement::close(
  self : HTMLDialogElement,
  return_value~ : @js.Optional[String] = @js.Optional::undefined()
) = "(self,returnValue) => self.close(returnValue)"

///|
pub extern "js" fn HTMLDialogElement::request_close(
  self : HTMLDialogElement,
  return_value~ : @js.Optional[String] = @js.Optional::undefined()
) = "(self, returnValue) => self.requestClose(returnValue)"

///|
pub extern "js" fn HTMLDialogElement::show(self : HTMLDialogElement) = "(self) => self.show()"

///|
pub extern "js" fn HTMLDialogElement::show_modal(self : HTMLDialogElement) = "(self) => self.showModal()"

///|
#external
type SVGImageElement

///|
#external
type HTMLVideoElement

///|
#external
type ImageBitmap

///|
#external
type OffscreenCanvas

///|
#external
type VideoFrame
