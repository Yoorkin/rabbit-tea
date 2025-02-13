///|
type Document

///|
pub extern "js" fn document() -> Document = "() => document"

///|
pub extern "js" fn get_element_by_id(
  self : Document,
  id : String
) -> @js.Nullable[Element] = "(doc,id) => doc.getElementById(id)"

///|
pub extern "js" fn create_element(self : Document, tag : String) -> Element = "(doc,tag) => doc.createElement(tag)"

///|
pub extern "js" fn create_text_node(self : Document, str : String) -> Element = "(doc,str) => doc.createTextNode(str)"

///|
pub extern "js" fn create_document_fragment(
  self : Document
) -> DocumentFragment = "(doc) => doc.createDocumentFragment()"
