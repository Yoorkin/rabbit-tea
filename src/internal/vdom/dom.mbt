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
  Node(
    String,
    attrs~ : Array[Attribute[Msg]],
    childrens~ : Array[Node[Msg]],
    // Store the event listener uesd in real DOM
    listeners~ : Array[(String, @ffi.Listener)]
  )
  KeyedNode(
    String,
    attrs~ : Array[Attribute[Msg]],
    childrens~ : Array[(String, Node[Msg])],
    listeners~ : Array[(String, @ffi.Listener)]
  )
  Text(String)
  Nothing
}

///| Convert msg type of Node.
/// 
/// This is a expensive operation and should be used rarely.
pub fn map[A, B](self : Node[A], f : (A) -> B) -> Node[B] {
  match self {
    Node(tag, attrs~, childrens~, listeners~) => {
      let attrs = attrs.map(fn(x) { x.map(f) })
      let childrens = childrens.map(fn(x) { x.map(f) })
      Node(tag, attrs~, childrens~, listeners~)
    }
    KeyedNode(key, attrs~, childrens~, listeners~) => {
      let attrs = attrs.map(fn(x) { x.map(f) })
      let childrens = childrens.map(fn(x) { (x.0, x.1.map(f)) })
      KeyedNode(key, attrs~, childrens~, listeners~)
    }
    Text(value) => Text(value)
    Nothing => Nothing
  }
}

///| Create a DOM node 
pub fn node[Msg](
  tag : String,
  attrs : Array[Attribute[Msg]],
  childrens : Array[Node[Msg]]
) -> Node[Msg] {
  Node(tag, attrs~, childrens~, listeners=[])
}

///|
pub fn keyed_node[Msg](
  key : String,
  attrs : Array[Attribute[Msg]],
  childrens : Array[(String, Node[Msg])]
) -> Node[Msg] {
  KeyedNode(key, attrs~, childrens~, listeners=[])
}

///| Create a plain text
pub fn text[Msg](value : String) -> Node[Msg] {
  Text(value)
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
  Custom(Msg, stop_progapation~ : Bool, prevent_default~ : Bool)
}

///|
fn is_same_type[Msg](x : Node[Msg], y : Node[Msg]) -> Bool {
  match (x, y) {
    (Node(_), Node(_)) => true
    (Text(_), Text(_)) => true
    (Nothing, Nothing) => true
    _ => false
  }
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
    Node(tag, attrs~, childrens~, ..) as node => {
      let element = @ffi.document().create_element(tag)
      attrs.each(fn {
        Attribute((event, AttrEvent(handler))) => {
          let listener = match handler {
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
          element.add_event_listener(event, listener)
          node.listeners.push((event, listener))
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
            guard let Ok(curr) = @url.parse?(@ffi.window().current_url())
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
    KeyedNode(key, attrs~, childrens~, listeners~) =>
      Node(key, attrs~, childrens=childrens.map(fn(x) { x.1 }), listeners~).to_node(
        sandbox,
      )
    Text(value) => @ffi.document().create_text_node(value).to_node()
    Nothing => @ffi.document().create_text_node("").to_node()
  }
}

///|
pub fn patch[Msg, Model, View](
  self : Node[Msg],
  old : Node[Msg],
  sandbox : @adapter.Sandbox[Msg, Model, View],
  mount~ : String
) -> Unit {
  let patches = diff(old, self)
  fn aux(patches : Patch[Msg], current : @ffi.Node) -> Unit {
    match patches {
      Drop(index, length) =>
        for i in 0..<length {
          current.remove_child(current.nth_child(index))
        }
      Remove(index) => current.remove_child(current.nth_child(index))
      Replace(index, node) =>
        current.replace_child(node.to_node(sandbox), current.nth_child(index))
      InsertBefore(index, node) =>
        if current.count_child() == 0 {
          current.append_child(node.to_node(sandbox))
        } else {
          current.insert_before(node.to_node(sandbox), current.nth_child(index))
        }
      Append(nodes) =>
        for node in nodes {
          current.append_child(node.to_node(sandbox))
        }
      Update(update) =>
        match update {
          UpdateNode(index, attrs_patches, childs_patches, new_listeners) => {
            let node = current.nth_child(index)
            let element = node.to_element()
            for patch in attrs_patches {
              match patch {
                AttrRemove(key) => element.remove_attribute(key)
                AttrAdd(key, value) => element.set_attribute(key, value)
                StyleAdd(key, value) => element.set_style(key, value)
                StyleRemove(key) => element.remove_style(key)
                PropertyAdd(key, value) => element.set_property(key, value)
                PropertyRemove(key) => element.remove_property(key)
                EventRemove(key, listener) =>
                  element.remove_event_listener(key, listener)
                EventAdd(key, handler) => {
                  let listener = match handler {
                    Normal(msg) => fn(_event) { sandbox.update(msg) }
                    HandleEvent(f) => fn(event) { sandbox.update(f(event)) }
                    Custom(msg, stop_progapation~, prevent_default~) =>
                      fn(event : @ffi.Event) {
                        if stop_progapation {
                          event.stop_propagation()
                        }
                        if prevent_default {
                          event.prevent_default()
                        }
                        sandbox.update(msg)
                      }
                  }
                  element.add_event_listener(key, listener)
                  new_listeners.push((key, listener))
                }
              }
            }
            for patch in childs_patches {
              aux(patch, node)
            }
          }
          UpdateText(index, value) => {
            let text_node = @ffi.document().create_text_node(value)
            current.replace_child(text_node.to_node(), current.nth_child(index))
          }
        }
    }
  }

  let root = @ffi.document().get_element_by_id(mount).to_node()
  aux(patches, root)
}

///|
enum AttrsUpdate[Msg] {
  AttrRemove(String)
  AttrAdd(String, String)
  StyleAdd(String, String)
  StyleRemove(String)
  PropertyAdd(String, String)
  PropertyRemove(String)
  EventRemove(String, @ffi.Listener)
  EventAdd(String, Handler[Msg])
}

///|
enum Patch[Msg] {
  Drop(Int, Int)
  Remove(Int)
  Replace(Int, Node[Msg])
  InsertBefore(Int, Node[Msg])
  Append(Array[Node[Msg]])
  Update(Update[Msg])
}

///|
enum Update[Msg] {
  UpdateNode(
    Int,
    Array[AttrsUpdate[Msg]],
    Array[Patch[Msg]],
    Array[(String, @ffi.Listener)]
  )
  UpdateText(Int, String)
}

///|
/// Now the root node must be a Node
pub fn diff[Msg](root_old : Node[Msg], root_new : Node[Msg]) -> Patch[Msg] {
  let (attrs_old, listeners) = match root_old {
    Node(_, attrs=attrs_old, listeners~, ..) => (attrs_old, listeners)
    KeyedNode(_, attrs=attrs_old, listeners~, ..) => (attrs_old, listeners)
    _ => abort("old is not a node or fragment")
  }
  let (attrs_new, _) = match root_new {
    Node(_, attrs=attrs_new, ..) => (attrs_new, [])
    KeyedNode(_, attrs=attrs_new, ..) => (attrs_new, [])
    _ => abort("new is not a node or fragment")
  }
  Update(
    UpdateNode(
      0,
      attrs_diff(attrs_old, attrs_new, listeners),
      do_diff(root_old, root_new),
      [],
    ),
  )
}

///|
pub fn do_diff[Msg](old : Node[Msg], new : Node[Msg]) -> Array[Patch[Msg]] {
  match (old, new) {
    (
      KeyedNode(_, childrens=childrens_old, ..),
      KeyedNode(_, childrens=childrens_new, ..),
    ) => diff_with_key(childrens_old, childrens_new)
    (Node(_, childrens=childrens_old, ..), Node(_, childrens=childrens_new, ..)) =>
      diff_without_key(childrens_old, childrens_new)
    (
      KeyedNode(_, childrens=childrens_old, ..),
      Node(_, childrens=childrens_new, ..),
    ) => diff_without_key(childrens_old.map(fn(x) { x.1 }), childrens_new)
    (
      Node(_, childrens=childrens_old, ..),
      KeyedNode(_, childrens=childrens_new, ..),
    ) => diff_without_key(childrens_old, childrens_new.map(fn(x) { x.1 }))
    _ => abort("old is not a node or fragment")
  }
}

// To be improved!!! Now this implementation will affect the performance of the diff algorithm.
// And If a AttrbuteString's name is same as a AttrEvent's name, the diff algorithm will not work.
// Now we think the events is different although they never changed.
///|
fn attrs_diff[Msg](
  old : Array[Attribute[Msg]],
  new : Array[Attribute[Msg]],
  // We think the event is different although they never changed.
  // The listeners is used to remove the event listener when the attribute is removed.
  listeners : Array[(String, @ffi.Listener)]
) -> Array[AttrsUpdate[Msg]] {
  let old_map = Map::from_iter(old.iter().map(fn(attr) { attr._ }))
  let new_map = Map::from_iter(new.iter().map(fn(attr) { attr._ }))
  let result = []
  for x in listeners {
    result.push(EventRemove(x.0, x.1))
  }
  for key, value in old_map {
    match value {
      // We think the event is different although they never changed.
      AttrEvent(_) => ()
      AttrStyle(value) =>
        if new_map.contains(key) {
          let AttrStyle(value_new) = new_map.get(key).unwrap()
          if value != value_new {
            result.push(StyleAdd(key, value_new))
          }
        } else {
          result.push(StyleRemove(key))
        }
      AttrString(value) =>
        if new_map.contains(key) {
          let AttrString(value_new) = new_map.get(key).unwrap()
          if value != value_new {
            result.push(AttrAdd(key, value_new))
          }
        } else {
          result.push(AttrRemove(key))
        }
      AttrProperty(value) =>
        if new_map.contains(key) {
          let AttrProperty(value_new) = new_map.get(key).unwrap()
          if value != value_new {
            result.push(PropertyAdd(key, value_new))
          }
        } else {
          result.push(PropertyRemove(key))
        }
    }
  }
  for key, value in new_map {
    match value {
      // We think the event is different although they never changed.
      AttrEvent(handler) => result.push(EventAdd(key, handler))
      AttrStyle(value) =>
        if not(old_map.contains(key)) {
          result.push(StyleAdd(key, value))
        }
      AttrString(value) =>
        if not(old_map.contains(key)) {
          result.push(AttrAdd(key, value))
        }
      AttrProperty(value) =>
        if not(old_map.contains(key)) {
          result.push(PropertyAdd(key, value))
        }
    }
  }
  result
}

///|
pub fn diff_pure[Msg](
  x : Node[Msg],
  y : Node[Msg],
  patches : Array[Patch[Msg]],
  index : Int
) -> Unit {
  if is_same_type(x, y) {
    match (x, y) {
      (
        Node(taga, attrs=xattrs, listeners~, ..),
        Node(tagb, attrs=yattrs, listeners=new_listeners, ..),
      ) =>
        if taga == tagb {
          let attrs_patches = attrs_diff(xattrs, yattrs, listeners)
          let childs_patches = do_diff(x, y)
          if attrs_patches.length() > 0 || childs_patches.length() > 0 {
            patches.push(
              Update(
                UpdateNode(index, attrs_patches, childs_patches, new_listeners),
              ),
            )
          }
        } else {
          patches.push(Replace(index, y))
        }
      (Text(value_a), Text(value_b)) =>
        if value_a != value_b {
          patches.push(Update(UpdateText(index, value_b)))
        }
      _ => ()
    }
  } else {
    patches.push(Replace(index, y))
  }
}

///|
pub fn diff_without_key[Msg](
  old : Array[Node[Msg]],
  new : Array[Node[Msg]]
) -> Array[Patch[Msg]] {
  fn aux(
    xs : ArrayView[Node[Msg]],
    ys : ArrayView[Node[Msg]],
    patches : Array[Patch[Msg]],
    index : Int
  ) -> Unit {
    match (xs, ys) {
      ([], []) => ()
      ([], tl) => patches.push(Append(tl.map(fn(x) { x })))
      (l, []) => patches.push(Drop(index, l.length()))
      ([x, .. tl1], [y, .. tl2]) => {
        diff_pure(x, y, patches, index)
        aux(tl1, tl2, patches, index + 1)
      }
    }
  }

  let patches = []
  aux(old[:], new[:], patches, 0)
  patches
}

///|
fn diff_with_key[Msg](
  old : Array[(String, Node[Msg])],
  new : Array[(String, Node[Msg])]
) -> Array[Patch[Msg]] {
  fn aux(
    xs : ArrayView[(String, Node[Msg])],
    ys : ArrayView[(String, Node[Msg])],
    patches : Array[Patch[Msg]],
    index : Int
  ) -> Unit {
    match (xs, ys) {
      ([], []) => ()
      ([], tl) => patches.push(Append(tl.map(fn(x) { x.1 })))
      (l, []) => patches.push(Drop(index, l.length()))
      ([x], [y]) => {
        let (key_x, x_1) = x
        let (key_y, y_1) = y
        if key_x == key_y {
          diff_pure(x_1, y_1, patches, index)
        } else {
          patches.push(Replace(index, y_1))
        }
      }
      ([x1, x2, .. tl1], [y]) => {
        let (key_x1, x1_1) = x1
        let (key_x2, x2_1) = x2
        let (key_y, y_1) = y
        if key_x1 == key_y {
          diff_pure(x1_1, y_1, patches, index)
          aux([x2, ..tl1][:], [][:], patches, index + 1)
        } else if key_x2 == key_y {
          patches.push(Remove(index))
          diff_pure(x2_1, y_1, patches, index)
          aux(tl1, [][:], patches, index + 1)
        } else {
          patches.push(Replace(index, y_1))
          aux([x2, ..tl1][:], [][:], patches, index + 1)
        }
      }
      ([x], [y1, y2, .. tl2]) => {
        let (key_x, x_1) = x
        let (key_y1, y1_1) = y1
        let (key_y2, y2_1) = y2
        if key_x == key_y1 {
          diff_pure(x_1, y1_1, patches, index)
          aux([][:], [y2, ..tl2][:], patches, index + 1)
        } else if key_x == key_y2 {
          diff_pure(x_1, y2_1, patches, index)
          patches.push(InsertBefore(index, y1_1))
          aux([][:], tl2, patches, index + 1)
        } else {
          patches.push(Replace(index, y1_1))
          aux([][:], [y2, ..tl2][:], patches, index + 1)
        }
      }
      ([x1, x2, .. tl1], [y1, y2, .. tl2]) => {
        let (key_x1, x1_1) = x1
        let (key_x2, x2_1) = x2
        let (key_y1, y1_1) = y1
        let (key_y2, y2_1) = y2
        if key_x1 == key_y1 {
          diff_pure(x1_1, y1_1, patches, index)
          aux([x2, ..tl1][:], [y2, ..tl2][:], patches, index + 1)
        } else {
          let i_ii_match = key_x1 == key_y2
          let ii_i_match = key_x2 == key_y1
          if i_ii_match && ii_i_match {
            patches.push(Remove(index))
            patches.push(InsertBefore(index + 1, y2_1))
            diff_pure(x2_1, y1_1, patches, index)
            aux(tl1, tl2, patches, index + 2)
          } else if i_ii_match {
            patches.push(InsertBefore(index, y1_1))
            diff_pure(x1_1, y2_1, patches, index + 1)
            aux([x2, ..tl1][:], tl2, patches, index + 2)
          } else if ii_i_match {
            patches.push(Remove(index))
            diff_pure(x2_1, y1_1, patches, index)
            aux(tl1, [y2, ..tl2][:], patches, index + 1)
          } else {
            patches.push(Replace(index, y1_1))
            aux([x2, ..tl1][:], [y2, ..tl2][:], patches, index + 1)
          }
        }
      }
    }
  }

  let patches = []
  aux(old[:], new[:], patches, 0)
  patches
}
