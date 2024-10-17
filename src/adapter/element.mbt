type Element

pub extern "js" fn create_element(tag : String) -> Element =
  #| (tag) => { var d = document.createElement(tag); console.log(d); return d; }
  #|

pub extern "js" fn create_text_node(str : String) -> Element =
  #| (str) => document.createTextNode(str)

pub extern "js" fn set_attribute(
  self : Element,
  attr : String,
  value : String
) -> Unit =
  #| (self,attr,value) => {
  #|  console.log("set_attr",self);
  #|  self.setAttribute(attr, value);
  #| }

pub extern "js" fn append_child(self : Element, child : Element) -> Unit =
  #| (self,child) => self.appendChild(child)

pub extern "js" fn patch(element : Element) -> Unit =
  #| (element) => {
  #|   const app = document.getElementById("app");
  #|   while(app.firstChild) app.removeChild(app.firstChild);
  #|   app.appendChild(element);
  #| }
  #| 
  #|
pub extern "js" fn listen(
  self : Element,
  event : String,
  callback : () -> Unit
) -> Unit =
  #| (self,event,callback) => self.addEventListener(event, callback)

