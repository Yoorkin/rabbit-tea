///|
#external
type Node

// ---------- node API --------------

///|
pub extern "js" fn Node::node_type(self : Self) -> Int = "(x) => x.nodeType"

///|
pub extern "js" fn Node::node_name(self : Self) -> String = "(x) => x.nodeName"

///|
pub extern "js" fn Node::node_value(self : Self) -> String = "(x) => x.nodeValue"

///|
pub extern "js" fn Node::first_child(self : Self) -> Node = "(x) => x.firstChild"

///|
pub extern "js" fn Node::last_child(self : Self) -> Node = "(x) => x.lastChild"

///|
pub extern "js" fn Node::next_sibling(self : Self) -> Node = "(x) => x.nextSibling"

///|
pub extern "js" fn Node::previous_sibling(self : Self) -> Node = "(x) => x.previousSibling"

///|
pub extern "js" fn Node::parent_node(self : Self) -> Node = "(x) => x.parentNode"

///|
pub extern "js" fn Node::append_child(self : Self, child : Node) = "(p,c) => p.appendChild(c)"

///|
pub extern "js" fn Node::remove_child(self : Self, child : Node) = "(p,c) => p.removeChild(c)"

///|
pub extern "js" fn Node::replace_child(self : Self, new : Node, old : Node) = "(p,n,o) => p.replaceChild(n,o)"

///|
pub extern "js" fn Node::insert_before(
  self : Self,
  value : Node,
  before : Node
) = "(p,value,before) => p.insertBefore(value,before)"

// ---------- some specific node API --------------
// Note: the childNodes property is a NodeList, not an array, so we can't use the Array type.

///|  
pub extern "js" fn Node::nth_child(self : Self, index : Int) -> Node =
  #| (x,i) => { 
  #|   const r = x.childNodes[i]; 
  #|   if (r === undefined) throw new Error(`nth_child: index ${i} out of bounds, length=${x.childNodes.length}`);
  #|   return r;
  #| }

///|
pub extern "js" fn Node::count_child(self : Self) -> Int = "(x) => x.childNodes.length"

///|
pub extern "js" fn Node::to_document(self : Self) -> @js.Nullable[Document] =
  #| (x) => x.nodeType===9 ? x : null

///|
pub extern "js" fn Node::to_document_fragment(
  self : Self
) -> @js.Nullable[DocumentFragment] =
  #| (x) => x.nodeType===11 ? x : null

///|
pub extern "js" fn Node::to_element(self : Self) -> @js.Nullable[Element] =
  #| (x) => x.nodeType===1 ? x : null

///|
pub extern "js" fn Node::to_text(self : Self) -> @js.Nullable[Text] =
  #| (x) => x.nodeType===3 ? x : null

///|
pub extern "js" fn Node::to_event_target(self : Self) -> EventTarget = "(x) => x"
