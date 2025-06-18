// ------------- cast node to other types -----------------

///|
pub extern "js" fn to_document(self : Node) -> @js.Nullable[Document] =
  #| (x) => x.nodeType===9 ? x : null

///|
pub extern "js" fn to_document_fragment(
  self : Node
) -> @js.Nullable[DocumentFragment] =
  #| (x) => x.nodeType===11 ? x : null

///|
pub extern "js" fn to_element(self : Node) -> @js.Nullable[Element] =
  #| (x) => x.nodeType===1 ? x : null

///|
pub extern "js" fn to_text(self : Node) -> @js.Nullable[Text] =
  #| (x) => x.nodeType===3 ? x : null

///|
pub extern "js" fn to_event_target(self : Node) -> EventTarget = "(x) => x"

// -------------- convert types back to node -----------------

///|
pub extern "js" fn Document::to_node(self : Document) -> Node = "(x) => x"

///|
pub extern "js" fn DocumentFragment::to_node(self : DocumentFragment) -> Node = "(x) => x"

///|
pub extern "js" fn Element::to_node(self : Element) -> Node = "(x) => x"

///|
pub extern "js" fn Text::to_node(self : Text) -> Node = "(x) => x"
