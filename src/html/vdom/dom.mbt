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

pub struct Node {
  tag : String
  attrs : Map[String, String]
  childrens : Array[Node]
  events : Map[String, () -> Unit]
}

fn to_element(self : Node) -> @adapter.Element {
  if self.tag == "plain-text" {
    @adapter.create_text_node(self.attrs["value"].unwrap())
  } else {
    let element = @adapter.create_element(self.tag)
    self.attrs.each(fn(k, v) { element.set_attribute(k, v) })
    self.childrens.each(fn(child) { element.append_child(to_element(child)) })
    self.events.each(fn(k, v) { 
      @adapter.listen(element, k, fn() { 
        println("event triggered at element \{self.tag}")
        v() 
      }) 
    })
    element
  }
}

pub fn patch(self : Node) -> Unit {
  let element = to_element(self)
  @adapter.patch(element)
}

pub enum Patch {
  Remove(Int)
  InsertAfter(Int, Node)
  Replace(Int, Node)
  MutateAttrs(Int, Map[String, String])
  MutateEvents(Int, Map[String, () -> Unit])
}

// impl @pp.Pretty for Patch with pretty(p) { @pp.text(p.to_string()) }

pub fn diff(self : Node, other : Node) -> Array[Patch] {
  let patches = []
  fn aux(xs : ArrayView[Node], ys : ArrayView[Node], index) -> Int {
    match (xs, ys) {
      ([], []) => index - 1
      ([], [new, .. as tl]) => {
        patches.push(InsertAfter(index, new))
        aux(xs, tl, index + 1)
      }
      ([_, .. as tl], []) => {
        patches.push(Remove(index))
        aux(tl, ys, index + 1)
      }
      ([old, .. as tl1], [new, .. as tl2]) => {
        if old.tag != new.tag {
          patches.push(Replace(index, new))
        } else if old.attrs != new.attrs {
          patches.push(MutateAttrs(index, new.attrs))
        } else if old.attrs != new.attrs {
          patches.push(MutateEvents(index, new.events))
        }
        let index = aux(old.childrens[:], new.childrens[:], index + 1)
        aux(tl1, tl2, index + 1)
      }
    }
  }

  aux([self][:], [other][:], 0) |> ignore()
  patches
}
