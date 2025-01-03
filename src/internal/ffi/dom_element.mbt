type Element
pub extern "js" fn count_childern(self : Element) -> Int = "(self) => self.children.length"
pub extern "js" fn get_childern(self : Element, index : Int) -> Element = "(self) => self.children[index]"
pub extern "js" fn append_childern(self : Element, child : Element) -> Unit = "(self, child) => self.append(child)"
pub extern "js" fn remove_childern(self : Element, child : Element) -> Unit = " (self,child) => self.remove(child) "
pub extern "js" fn set_attribute(
  self : Element,
  attr : String,
  value : String
) -> Unit = "(self,attr,value) => self.setAttribute(attr, value)"
pub extern "js" fn remove_attribute(self : Element, attr : String) -> Unit = "(self,attr) => self.removeAttribute(attr)"
pub extern "js" fn add_event_listener(
  self : Element,
  event : String,
  callback : (Event) -> Unit
) -> Unit = "(self,event,callback) => self.addEventListener(event, callback)"
pub extern "js" fn remove_event_listener(
  self : Element,
  event : String,
  callback : (Event) -> Unit
) -> Unit = "(self,event,callback) => self.removeEventListener(event, callback)"
pub extern "js" fn scroll_into_view(self : Element) -> Unit = "(self) => self.scrollIntoView()"
pub extern "js" fn set_inner_html(self : Element, html : String) -> Unit = "(self,html) => self.innerHTML = html"
