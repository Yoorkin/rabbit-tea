// in dom_wbtest.mbt
test "keyed1" {
  let old = [
    ("b", node("tag_b", [], [])),
    ("a", node("tag_a", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let new = [
    ("a", node("tag_a", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|Remove(0)
      #|InsertBefore(2, Node(tag_b))
      #|
    ,
  )
}

test "keyed2" {
  let old = [
    ("b", node("tag_b", [], [])),
    ("d", node("tag_d", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let new = [
    ("a", node("tag_a", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|InsertBefore(0, Node(tag_a))
      #|Remove(2)
      #|
    ,
  )
}

test "keyed3" {
  let old = [
    ("f", node("tag_f", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let new = [
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
    ("d", node("tag_d", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|Remove(0)
      #|Append(1 ["Node(tag_d)"])
      #|
    ,
  )
}


test "keyed4" {
  let old = [
    ("b", node("tag_b", [], [])),
    ("h", node("tag_h", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let new = [
    ("a", node("tag_a", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|InsertBefore(0, Node(tag_a))
      #|Remove(2)
      #|
    ,
  )
}

///|
pub fn node_to_string[Msg](node : Node[Msg]) -> String {
  match node {
    Node(tag) => "Node(\{tag})"
    Text(value) => "Text(\{value})"
    Nothing => "Nothing"
    KeyedNode(tag) => "KeyedNode(\{tag})"
  }
}

///| Convert patch to string
pub fn patch_to_string[Msg](patch : Patch[Msg]) -> String {
  fn aux(patch : Patch[Msg], indent : Int) -> String {
    let indent_str = " ".repeat(indent)
    match patch {
      Drop(index, length) =>
        indent_str +
        "Drop(" +
        index.to_string() +
        ", " +
        length.to_string() +
        ")\n"
      Remove(index) => indent_str + "Remove(" + index.to_string() + ")\n"
      Replace(index, node) =>
        indent_str +
        "Replace(" +
        index.to_string() +
        ", \{node_to_string(node)})\n"
      InsertBefore(index, node) =>
        indent_str +
        "InsertBefore(" +
        index.to_string() +
        ", \{node_to_string(node)})\n"
      Append(nodes) =>
        indent_str +
        "Append(" +
        nodes.length().to_string() +
        " \{nodes.map(node_to_string)})\n"
      Update(update) =>
        match update {
          UpdateNode(index, _, childs_patches, _) =>
            indent_str +
            "UpdateNode(" +
            index.to_string() +
            ")\n" +
            String::concat(childs_patches.map(fn(p) { aux(p, indent + 2) }))
          UpdateText(index, value) =>
            indent_str +
            "UpdateText(" +
            index.to_string() +
            ", " +
            value +
            ")\n"
        }
    }
  }

  aux(patch, 0)
}
