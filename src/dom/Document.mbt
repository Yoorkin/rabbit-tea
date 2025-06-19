///|
#external
type Document

///|
pub extern "js" fn document() -> Document = "() => document"

///|
pub extern "js" fn create_element(self : Document, tag : String) -> Element = "(doc,tag) => doc.createElement(tag)"

///|
pub extern "js" fn create_text_node(self : Document, str : String) -> Element = "(doc,str) => doc.createTextNode(str)"

///|
pub extern "js" fn create_document_fragment(
  self : Document
) -> DocumentFragment = "(doc) => doc.createDocumentFragment()"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById
pub extern "js" fn Document::get_element_by_id(
  self : Self,
  id : String
) -> @js.Nullable[Element] = "(doc,id) => doc.getElementById(id)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByClassName
pub extern "js" fn Document::get_elements_by_class_name(
  self : Self,
  names : String
) -> HTMLCollection = "(doc,names) => doc.getElementsByClassName(names)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByName
pub extern "js" fn Document::get_elements_by_name(
  self : Self,
  name : String
) -> NodeList = "(doc,name) => doc.getElementsByName(name)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagName
pub extern "js" fn Document::get_elements_by_tag_name(
  self : Self,
  tag : String
) -> HTMLCollection = "(doc,tag) => doc.getElementsByTagName(tag)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagNameNS
pub extern "js" fn Document::get_elements_by_tag_name_ns(
  self : Self,
  namespace_ : String,
  name : String
) -> HTMLCollection = "(doc,namespace,name) => doc.getElementsByTagNameNS(namespace, name)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
pub extern "js" fn query_selector(
  self : Document,
  selectors : String
) -> @js.Nullable[Element] = "(self,selectors) => self.querySelector(selectors)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll
pub extern "js" fn query_selector_all(
  self : Document,
  selectors : String
) -> NodeList = "(self,selectors) => self.querySelectorAll(selectors)"
