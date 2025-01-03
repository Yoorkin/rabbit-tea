/// Things need to do:
/// - The braces and parentheses in comments and string should not be highlighted.
/// - ArrayView can be pattern matched by [], but cannot be constructed like that.
/// - Documentation in mooncakes.io is not convient to use
///     - members should be listed by order
///     - search
/// - If you create this package and click `run test` in test.mbt, 
///   it will complain that `moon.mod.json` not found, unless you moon clean and moon check first.
/// 
/// - All imports in moon.pkg.json used absolute path, 
///   if i changes the module name, all moon.pkg.json need to be changed.
/// 
/// - Function type does not implement Show trait
///
/// - Need a Dispose trait to maintains the FFI resource
/// 
/// - Need Map::map_values  
/// - Need Iter::filter_map
/// - Type of Map::iter() is not Iter2

///|
pub(all) struct Node {
  tag : String
  attrs : Map[String, String]
  childrens : Array[Node]
  events : Map[String, (@ffi.Event) -> Unit]
}

///|
impl @pp.Pretty for Node with pretty(node) {
  @pp.group(
    @pp.text("<\{node.tag} \{node.attrs}>") +
    @pp.nest(
      indent=2,
      @pp.line + @pp.separate_map(@pp.line, node.childrens, @pp.pretty),
    ) +
    @pp.line +
    @pp.text("</\{node.tag}>"),
  )
}

///|
impl Show for Node with output(node, buf) {
  buf.write_string(@pp.render(@pp.pretty(node)))
}

///|
typealias Nodes = Array[Node]

///| Return a new div node 
pub fn empty() -> Node {
  { tag: "div", attrs: {}, childrens: [], events: {} }
}

///|
pub const FragmentTag = "fragment"

///|
pub const PlainTextTag = "plain-text"

///|
pub const NothingTag = "nothing"

///| convert a vdom node to a ffi node
fn to_node(self : Node) -> @ffi.Node {
  match self.tag {
    FragmentTag => {
      let fragment = @ffi.document().create_document_fragment().to_node()
      for child in self.childrens {
        fragment.append_child(child.to_node())
      }
      fragment
    }
    PlainTextTag =>
      @ffi.document().create_text_node(self.attrs["value"].unwrap()).to_node()
    NothingTag => @ffi.document().create_document_fragment().to_node()
    _ => {
      let element = @ffi.document().create_element(self.tag)
      self.attrs.each(fn(k, v) { element.set_attribute(k, v) })
      for k, v in self.events {
        @ffi.add_event_listener(element, k, fn(e) { v(e) })
      }
      let node = element.to_node()
      for child in self.childrens {
        node.append_child(child.to_node())
      }
      node
    }
  }
}

///|
pub fn patch(self : Node, old : Node, root_id~ : String) -> Unit {
  let patch = diff(self, old)
  fn aux(patch : Patch, current : @ffi.Node, offset : Int) -> Unit {
    match patch {
      Remove(index) => current.remove_child(current.nth_child(index))
      InsertBefore(index, vnode) => {
        let anchor = current.nth_child(index)
        current.insert_before(vnode.to_node(), anchor)
      }
      Append(vnode) => current.append_child(vnode.to_node())
      Replace(index, vnode) => {
        let old = current.nth_child(index)
        current.replace_child(vnode.to_node(), old)
      }
      Update(index, attrs, events, patches) => {
        let node = current.nth_child(index)
        if patches.length() != 0 {
          let element = node.to_element()
          attrs.each(fn(k, v) { element.set_attribute(k, v) })
          for k, v in events {
            element.add_event_listener(k, fn(e) { v(e) })
          }
          for patch in patches {
            aux(patch, node, 0)
          }
        }
      }
    }
  }

  let root = @ffi.document().get_element_by_id(root_id)
  aux(patch, root.to_node(), 0)
}

///|
enum Patch {
  Remove(Int) // remove a node
  InsertBefore(Int, Node) // insert before a node
  Append(Node) // append a new node to the end
  Replace(Int, Node) // replace with a new node
  Update(
    Int,
    Map[String, String],
    Map[String, (@ffi.Event) -> Unit],
    Array[Patch]
  ) // patches for it's childrens
}

///|
impl @pp.Pretty for Patch with pretty(patch) {
  match patch {
    Remove(index) => @pp.text("Remove(\{index})")
    InsertBefore(index, vnode) =>
      @pp.text("InsertBefore") +
      @pp.parens(
        @pp.nest(
          @pp.line + @pp.text("\{index},") + @pp.line + @pp.pretty(vnode),
        ),
      )
    Append(vnode) =>
      @pp.text("Append") + @pp.parens(@pp.nest(@pp.line + @pp.pretty(vnode)))
    Replace(index, vnode) =>
      @pp.text("Replace") +
      @pp.parens(
        @pp.nest(
          @pp.line +
          @pp.pretty(index) +
          @pp.char(',') +
          @pp.line +
          @pp.pretty(vnode),
        ),
      )
    Update(index, attrs, events, patches) =>
      @pp.text("Update(\{index}, attrs=\{attrs}, events=\{events.size()}, ") +
      @pp.pretty(patches) +
      @pp.text(")")
  }
}

///|
impl Show for Patch with output(patch, buf) {
  buf.write_string(@pp.render(@pp.pretty(patch)))
}

///|
pub fn diff(self : Node, old : Node) -> Patch {
  println("new:\n \{self}\n\nold:\n\{old}")
  fn neq_events(old, new) {
    true
  }

  fn aux(
    xs : ArrayView[Node],
    ys : ArrayView[Node],
    patches : Array[Patch],
    index
  ) -> Unit {
    match (xs, ys) {
      ([], []) => ()
      ([], [new, .. as tl]) => {
        patches.push(Append(new))
        aux(xs, tl, patches, index + 1)
      }
      ([_, .. as tl], []) => {
        patches.push(Remove(index))
        aux(tl, ys, patches, index)
      }
      ([old, .. as tl1], [new, .. as tl2]) => {
        if old.tag != new.tag {
          patches.push(Replace(index, new))
        } else {
          let attrs = if old.attrs != new.attrs { new.attrs } else { {} }
          let events = if neq_events(old.events, new.events) {
            new.events
          } else {
            {}
          }
          let sub_patches = []
          patches.push(Update(index, attrs, events, sub_patches))
          aux(old.childrens[:], new.childrens[:], sub_patches, 0)
        }
        aux(tl1, tl2, patches, index + 1)
      }
    }
  }

  let root_patches = []
  aux([old][:], [self][:], root_patches, 0)
  guard let [patch] = root_patches
  println("diff: \{patch}")
  patch
}

// pub enum Patch[Msg, Model, View] {
//   Remove(Int)
//   InsertAfter(Int, Node)
//   Replace(Int, Node)
//   MutateAttrs(Int, Map[String, String])
//   MutateEvents(Int, Map[String, () -> Unit])
// }

// // impl @pp.Pretty for Patch with pretty(p) { @pp.text(p.to_string()) }

// pub fn diff[Msg, Model, View](
//   self : Node,
//   other : Node
// ) -> Array[Patch[Msg, Model, View]] {
//   let patches = []
//   fn aux(xs : ArrayView[Node], ys : ArrayView[Node], index) -> Int {
//     match (xs, ys) {
//       ([], []) => index - 1
//       ([], [new, .. as tl]) => {
//         patches.push(InsertAfter(index, new))
//         aux(xs, tl, index + 1)
//       }
//       ([_, .. as tl], []) => {
//         patches.push(Remove(index))
//         aux(tl, ys, index + 1)
//       }
//       ([old, .. as tl1], [new, .. as tl2]) => {
//         if old.tag != new.tag {
//           patches.push(Replace(index, new))
//         } else if old.attrs != new.attrs {
//           patches.push(MutateAttrs(index, new.attrs))
//         } else if old.attrs != new.attrs {
//           patches.push(MutateEvents(index, new.events))
//         }
//         let index = aux(old.childrens[:], new.childrens[:], index + 1)
//         aux(tl1, tl2, index + 1)
//       }
//     }
//   }

//   aux([self][:], [other][:], 0) |> ignore()
//   patches
// }
