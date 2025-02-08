///|
type Node

// ---------- node API --------------
///|
pub extern "js" fn node_type(self : Node) -> Int = "(x) => x.nodeType"

///|
pub extern "js" fn node_name(self : Node) -> String = "(x) => x.nodeName"

///|
pub extern "js" fn node_value(self : Node) -> String = "(x) => x.nodeValue"

///|
pub extern "js" fn first_child(self : Node) -> Node = "(x) => x.firstChild"

///|
pub extern "js" fn last_child(self : Node) -> Node = "(x) => x.lastChild"

///|
pub extern "js" fn next_sibling(self : Node) -> Node = "(x) => x.nextSibling"

///|
pub extern "js" fn previous_sibling(self : Node) -> Node = "(x) => x.previousSibling"

///|
pub extern "js" fn parent_node(self : Node) -> Node = "(x) => x.parentNode"

///|
pub extern "js" fn append_child(self : Node, child : Node) = "(p,c) => p.appendChild(c)"

///|
pub extern "js" fn remove_child(self : Node, child : Node) = "(p,c) => p.removeChild(c)"

///|
pub extern "js" fn replace_child(self : Node, new : Node, old : Node) = "(p,n,o) => p.replaceChild(n,o)"

///|
pub extern "js" fn insert_before(self : Node, value : Node, before : Node) = "(p,value,before) => p.insertBefore(value,before)"

// ---------- some specific node API --------------
// Note: the childNodes property is a NodeList, not an array, so we can't use the Array type.
///|  
pub extern "js" fn nth_child(self : Node, index : Int) -> Node =
  #| (x,i) => { 
  #|   const r = x.childNodes[i]; 
  #|   if (r === undefined) throw new Error(`nth_child: index ${i} out of bounds`);
  #|   return r;
  #| }

///|
pub extern "js" fn count_child(self : Node) -> Int = "(x) => x.childNodes.length"
