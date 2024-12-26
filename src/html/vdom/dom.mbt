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
  events : Map[String, (@adapter.Event) -> Unit]
}

///|
pub const FragmentTag = "fragment"

///|
pub const PlainTextTag = "plain-text"

///|
pub const NothingTag = "nothing"

///|
fn to_element[Msg, Model, View](
  self : Node,
  sandbox : @adapter.Sandbox[Msg, Model, View]
) -> Array[@adapter.Element] {
  match self.tag {
    FragmentTag => {
      let xs = []
      for child in self.childrens {
        xs.append(to_element(child, sandbox))
      }
      xs
    }
    PlainTextTag => [@adapter.create_text_node(self.attrs["value"].unwrap())]
    NothingTag => []
    _ => {
      let element = @adapter.create_element(self.tag)
      self.attrs.each(fn(k, v) { element.set_attribute(k, v) })
      for child in self.childrens {
        for elem in to_element(child, sandbox) {
          element.append_child(elem)
        }
      }
      for k, v in self.events {
        @adapter.listen(element, k, fn(e) { v(e) })
      }
      [element]
    }
  }
}

///|
pub fn patch[Msg, Model, View](
  self : Node,
  sandbox : @adapter.Sandbox[Msg, Model, View]
) -> Unit {
  let xs = to_element(self, sandbox)
  let element = if xs.length() != 1 {
    let element = @adapter.create_element("div")
    xs.each(fn(x) { element.append_child(x) })
    element
  } else {
    xs[0]
  }
  @adapter.patch(element)
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
