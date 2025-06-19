///|
#external
type Element

///|
pub extern "js" fn Element::to_node(self : Self) -> Node = "(x) => x"

///|
pub extern "js" fn Element::to_html_element(
  self : Self
) -> @js.Nullable[HTMLElement] =
  #| (x) => x instanceof HTMLElement ? x : null

///|
pub extern "js" fn Element::children(self : Self) -> Array[Element] =
  #| (self) => self.children

///|
pub extern "js" fn Element::append_children(
  self : Self,
  child : Element
) -> Unit = "(self, child) => self.append(child)"

///|
pub extern "js" fn Element::remove_children(
  self : Self,
  child : Element
) -> Unit = " (self,child) => self.remove(child) "

// NOTE: The DOM tree also includes the TEXT_NODE, which is not an element.
// Therefore, a vdom patch algorithm should not be based on the ffi above.
// https://dom.spec.whatwg.org/#ref-for-dom-node-nodetype%E2%91%A0

///|
pub extern "js" fn Element::set_attribute(
  self : Self,
  attr : String,
  value : String
) -> Unit = "(self,attr,value) => self.setAttribute(attr, value)"

///|
pub extern "js" fn Element::get_attribute(self : Self, attr : String) -> String = "(self,attr) => self.getAttribute(attr)"

///|
pub extern "js" fn Element::remove_attribute(
  self : Self,
  attr : String
) -> Unit = "(self,attr) => self.removeAttribute(attr)"

///| 
pub extern "js" fn Element::set_property(
  self : Self,
  prop : String,
  value : @js.Value
) = "(self,prop,value) => self[prop] = value"

///|
pub extern "js" fn Element::remove_property(self : Self, prop : String) -> Unit = "(self,prop) => delete self[prop]"

///|
pub extern "js" fn Element::get_property(self : Self, prop : String) -> String = "(self,prop) => self[prop]"

///| https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView
pub extern "js" fn Element::scroll_into_view(self : Self) = "(self) => self.scrollIntoView()"

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
pub extern "js" fn Element::set_inner_html(self : Self, html : String) -> Unit = "(self,html) => self.innerHTML = html"

///|
pub extern "js" fn Element::get_bounding_client_rect(self : Self) -> DOMRect =
  #| (self) => self.getBoundingClientRect()
