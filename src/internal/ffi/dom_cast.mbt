// ------------- cast node to other types -----------------
///|
pub extern "js" fn to_document(self : Node) -> Document =
  #| (x) => { if(x.nodeType===9) { return x; } else { throw new Error("not a DOCUMENT_NODE") }; }

///|
pub extern "js" fn to_document_fragment(self : Node) -> DocumentFragment =
  #| (x) => { if(x.nodeType===11) { return x; } else { throw new Error("not a DOCUMENT_FRAGMENT_NODE") }; }

///|
pub extern "js" fn to_element(self : Node) -> Element =
  #| (x) => { if(x.nodeType===1) { return x; } else { throw new Error(`${x} (${x.nodeType}) not an ELEMENT_NODE`) }; }

///|
pub extern "js" fn to_text(self : Node) -> Text =
  #| (x) => { if(x.nodeType===3) { return x; } else { throw new Error("not an TEXT_NODE") }; }

// -------------- convert types back to node -----------------
///|
pub extern "js" fn Document::to_node(self : Document) -> Node = "(x) => x"

///|
pub extern "js" fn DocumentFragment::to_node(self : DocumentFragment) -> Node = "(x) => x"

///|
pub extern "js" fn Element::to_node(self : Element) -> Node = "(x) => x"

///|
pub extern "js" fn Text::to_node(self : Text) -> Node = "(x) => x"

///| Check if a node is null or undefined 
/// Some js functions may return null or undefined, so we need to check for return value
pub extern "js" fn is_null(self : Node) -> Bool = "(x) => x === null || x === undefined"
