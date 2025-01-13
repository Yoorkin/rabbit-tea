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
enum Node[Msg] {
  Node(String, attrs~ : Array[Attribute[Msg]], childrens~ : Array[Node[Msg]])
  Text(String)
  Fragment(Array[Node[Msg]])
  Nothing
}

///| Convert msg type of Node.
/// 
/// This is a expensive operation and should be used rarely.
pub fn map[A, B](self : Node[A], f : (A) -> B) -> Node[B] {
  match self {
    Node(tag, attrs~, childrens~) => {
      let attrs = attrs.map(fn(x) { x.map(f) })
      let childrens = childrens.map(fn(x) { x.map(f) })
      Node(tag, attrs~, childrens~)
    }
    Text(value) => Text(value)
    Fragment(childrens) => Fragment(childrens.map(fn(x) { x.map(f) }))
    Nothing => Nothing
  }
}

///| Create a DOM node 
pub fn node[Msg](
  tag : String,
  attrs : Array[Attribute[Msg]],
  childrens : Array[Node[Msg]]
) -> Node[Msg] {
  Node(tag, attrs~, childrens~)
}

///| Create a plain text
pub fn text[Msg](value : String) -> Node[Msg] {
  Text(value)
}

///| Create a fragment
pub fn fragment[Msg](childrens : Array[Node[Msg]]) -> Node[Msg] {
  Fragment(childrens)
}

///| Create a dummy node
pub fn nothing[Msg]() -> Node[Msg] {
  Nothing
}

///|
type Attribute[Msg] (String, AttrValue[Msg])

///|
enum AttrValue[Msg] {
  AttrEvent(Handler[Msg])
  AttrStyle(String)
  AttrString(String)
  // NOTE: Property is used to set the property of the element, this is different 
  // from the AttrString, which set the attribute of the element.
  // See https://github.com/elm/html/blob/master/properties-vs-attributes.md
  //
  // Futher more, the behavior of property may be different with attribute, even 
  // they have the same name. For example, if you set the `href` by `setAttribute`, the
  // `href` will be the value you specified, but by property, the value will be 
  // resolved to an absolute URL. 
  AttrProperty(String)
}

///|
pub(all) enum Handler[Msg] {
  Normal(Msg)
  HandleEvent((@ffi.Event) -> Msg)
  TriggerUrlChange(String)
  Custom(Msg, stop_progapation~ : Bool, prevent_default~ : Bool)
}

///|
impl[Msg] Eq for Handler[Msg] with op_equal(a, b) {
  false // TODO: implement this
}

///|
impl[Msg] Eq for AttrValue[Msg] with op_equal(a, b) {
  false // TODO: implement this
}

///|
impl[Msg] Eq for Attribute[Msg] with op_equal(a, b) {
  false // TODO: implement this
}

///|
pub fn map[A, B](self : Handler[A], f : (A) -> B) -> Handler[B] {
  match self {
    Normal(msg) => Normal(f(msg))
    HandleEvent(g) => HandleEvent(fn(event) { g(event) |> f })
    Custom(msg, stop_progapation~, prevent_default~) =>
      Custom(f(msg), stop_progapation~, prevent_default~)
  }
}

///|
pub fn map[A, B](self : Attribute[A], f : (A) -> B) -> Attribute[B] {
  let Attribute((key, value)) = self
  let value = match value {
    AttrEvent(handler) => AttrEvent(handler.map(f))
    AttrStyle(value) => AttrStyle(value)
    AttrString(value) => AttrString(value)
    AttrProperty(value) => AttrProperty(value)
  }
  Attribute((key, value))
}

///| Create an custom event handler
pub fn on[Msg](event : String, handler : Handler[Msg]) -> Attribute[Msg] {
  (event, AttrEvent(handler))
}

///| Create an attribute
pub fn attribute[Msg](key : String, value : String) -> Attribute[Msg] {
  (key, AttrString(value))
}

///| Create an property
pub fn property[Msg](key : String, value : String) -> Attribute[Msg] {
  (key, AttrProperty(value))
}

///| Create an style attribute
pub fn style[Msg](key : String, value : String) -> Attribute[Msg] {
  (key, AttrStyle(value))
}

///| Convert virtual DOM to real DOM
fn to_node[Msg, Model, View](
  self : Node[Msg],
  sandbox : @adapter.Sandbox[Msg, Model, View]
) -> @ffi.Node {
  // NOTE:
  // In Elm, the sandbox is a spacial type and handled in the runtime. But in Moonbit,
  // the sandbox is just a normal type and handled in the user code. Because any operation
  // in TEA require the state of sandbox, it cause the type parameter like Msg, Model, View 
  // to be passed around in API, very painful.
  // 
  // This function require a sandbox value, and use closure to eliminate the type parameter.
  match self {
    Node(tag, attrs~, childrens~) => {
      let element = @ffi.document().create_element(tag)
      attrs.each(fn {
        Attribute((event, AttrEvent(handler))) => {
          let cb = match handler {
            Normal(msg) => fn(_event) { sandbox.update(msg) }
            HandleEvent(f) => fn(event) { sandbox.update(f(event)) }
            Custom(msg, stop_progapation~, prevent_default~) =>
              fn(event : @ffi.Event) { // TODO: remove this annotation will cause type error, why?
                if stop_progapation {
                  event.stop_propagation()
                }
                if prevent_default {
                  event.prevent_default()
                }
                sandbox.update(msg)
              }
          }
          element.add_event_listener(event, cb)
        }
        Attribute((key, AttrString(value))) => element.set_attribute(key, value)
        Attribute((key, AttrStyle(value))) => element.set_style(key, value)
        Attribute((key, AttrProperty(value))) =>
          element.set_property(key, value)
      })
      // NOTE:
      // This is important for those who want to write a router in the app. 
      // When the `a` tag is clicked, the href is parsed and wrapped in 
      // the `url_request` message, then resent to the update function. 
      //
      // If the `url_request` message was not provided, let the browser 
      // handle the click event.
      match (sandbox.get_on_url_request(), tag) {
        (Some(url_request), "a") =>
          element.add_event_listener("click", fn(event) {
            event.prevent_default()
            let href = element.get_property("href")
            guard let Ok(curr) = @url.parse?(@ffi.current_url())
            guard let Ok(next) = @url.parse?(href)
            let request = if curr.protocol == next.protocol &&
              curr.host == next.host &&
              curr.port == next.port {
              @adapter.Internal(next)
            } else {
              External(href)
            }
            sandbox.update(url_request(request))
          })
        _ => ()
      }
      for child in childrens {
        element.to_node().append_child(to_node(child, sandbox))
      }
      element.to_node()
    }
    Text(value) => @ffi.document().create_text_node(value).to_node()
    Fragment(childrens) => {
      let node = @ffi.document().create_document_fragment().to_node()
      for child in childrens {
        node.append_child(to_node(child, sandbox))
      }
      node
    }
    Nothing => @ffi.document().create_document_fragment().to_node()
  }
}

///|
pub fn patch[Msg, Model, View](
  self : Node[Msg],
  old : Node[Msg],
  sandbox : @adapter.Sandbox[Msg, Model, View],
  mount~ : String
) -> Unit {
  let patch = diff(self, old)
  fn aux(patch : Patch[Msg], current : @ffi.Node, offset : Int) -> Unit {
    match patch {
      Remove(index) => current.remove_child(current.nth_child(index))
      InsertBefore(index, vnode) => {
        let anchor = current.nth_child(index)
        let vdoms = vnode.to_node(sandbox)
        current.insert_before(vnode.to_node(sandbox), anchor)
      }
      Append(vnode) => current.append_child(vnode.to_node(sandbox))
      Replace(index, vnode) => {
        let old = current.nth_child(index)
        current.replace_child(vnode.to_node(sandbox), old)
      }
      Update(index, attrs, patches) => {
        let node = current.nth_child(index)
        if patches.length() != 0 {
          let element = node.to_element()
          //TODO: Update attributes
          for patch in patches {
            aux(patch, node, 0)
          }
        }
      }
    }
  }

  let root = @ffi.document().get_element_by_id(mount).to_node()
  aux(patch, root, 0)
}

///|
pub fn diff[Msg](self : Node[Msg], old : Node[Msg]) -> Patch[Msg] {
  fn aux(
    xs : ArrayView[Node[Msg]],
    ys : ArrayView[Node[Msg]],
    patches : Array[Patch[Msg]],
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
      ([old, .. as tl1], [new, .. as tl2]) =>
        match (old, new) {
          (
            Node(tag1, attrs=attrs1, childrens=childrens1),
            Node(tag2, attrs=attrs2, childrens=childrens2),
          ) => {
            // TODO: compare attributes
            let attrs = if attrs1 != attrs2 { attrs2 } else { [] }
            let sub_patches = []
            patches.push(Update(index, [], sub_patches))
            aux(childrens1[:], childrens2[:], sub_patches, index)
          }
          (Text(value1), Text(value2)) =>
            if value1 != value2 {
              patches.push(Replace(index, new))
            }
          (Fragment(childrens1), Fragment(childrens2)) => {
            let sub_patches = []
            patches.push(Update(index, [], sub_patches))
            aux(childrens1[:], childrens2[:], sub_patches, index)
          }
          (Nothing, Nothing) => ()
          (_, _) => patches.push(Replace(index, new))
        }
    }
  }

  let root_patches = []
  aux([old][:], [self][:], root_patches, 0)
  guard let [patch] = root_patches
  patch
}

///|
enum Patch[Msg] {
  Remove(Int) // remove a node
  InsertBefore(Int, Node[Msg]) // insert before a node
  Append(Node[Msg]) // append a new node to the end
  Replace(Int, Node[Msg]) // replace with a new node
  Update(Int, Array[Attribute[Msg]], Array[Patch[Msg]]) // patches for it's childrens
}
