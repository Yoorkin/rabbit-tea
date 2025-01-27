///|
type Element

///|
pub extern "js" fn count_children(self : Element) -> Int = "(self) => self.children.length"

///|
pub extern "js" fn get_children(self : Element, index : Int) -> Element = "(self, index) => self.children[index]"

///|
pub extern "js" fn append_children(self : Element, child : Element) -> Unit = "(self, child) => self.append(child)"

///|
pub extern "js" fn remove_children(self : Element, child : Element) -> Unit = " (self,child) => self.remove(child) "

// NOTE: The DOM tree also includes the TEXT_NODE, which is not an element.
// Therefore, a vdom patch algorithm should not be based on the ffi above.
// https://dom.spec.whatwg.org/#ref-for-dom-node-nodetype%E2%91%A0

///|
pub extern "js" fn set_attribute(
  self : Element,
  attr : String,
  value : String
) -> Unit = "(self,attr,value) => self.setAttribute(attr, value)"

///| 
pub extern "js" fn set_property(self : Element, prop : String, value : String) = "(self,prop,value) => self[prop] = value"

///|
pub extern "js" fn remove_property(self : Element, prop : String) -> Unit = "(self,prop) => delete self[prop]"

///|
pub extern "js" fn get_property(self : Element, prop : String) -> String = "(self,prop) => self[prop]"

///|
pub extern "js" fn get_attribute(self : Element, attr : String) -> String = "(self,attr) => self.getAttribute(attr)"

///|
pub extern "js" fn set_style(
  self : Element,
  key : String,
  value : String
) -> Unit = "(self,key,value) => self.style[key] = value"

///|
pub extern "js" fn remove_style(self : Element, key : String) -> Unit = "(self,key) => self.style[key] = ''"

///|
pub extern "js" fn remove_attribute(self : Element, attr : String) -> Unit = "(self,attr) => self.removeAttribute(attr)"

///|
pub extern "js" fn add_event_listener(
  self : Element,
  event : String,
  listener : Listener
) -> Unit = "(self,event,callback) => self.addEventListener(event, callback)"

///|
pub extern "js" fn remove_event_listener(
  self : Element,
  event : String,
  listener : Listener
) -> Unit = "(self,event,callback) => self.removeEventListener(event, callback)"

///|
pub extern "js" fn scroll_into_view(self : Element) -> Unit = "(self) => self.scrollIntoView()"

///|
pub extern "js" fn set_inner_html(self : Element, html : String) -> Unit = "(self,html) => self.innerHTML = html"
