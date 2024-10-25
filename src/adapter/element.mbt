type Element

pub extern "js" fn create_element(tag : String) -> Element =
  #| (tag) => document.createElement(tag) 
  #|

pub extern "js" fn create_text_node(str : String) -> Element =
  #| (str) => document.createTextNode(str)

pub extern "js" fn set_attribute(
  self : Element,
  attr : String,
  value : String
) -> Unit =
  #| (self,attr,value) => {
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
  callback : (Event) -> Unit
) -> Unit =
  #| (self,event,callback) => self.addEventListener(event, callback)

type Event

type EventTarget

pub extern "js" fn target(self : Event) -> EventTarget =
  #| (self) => self.target

pub extern "js" fn value(self : EventTarget) -> String =
  #| (self) => self.value
