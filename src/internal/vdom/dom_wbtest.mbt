// in dom_wbtest.mbt
test "i_ii + ii_i" {
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
      #|InsertBefore(1, Node(tag_b))
      #|
    ,
  )
}

test "i_ii_match_1" {
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

test "ii_i_match_1" {
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

test "ii_i_match_2" {
  let old = [
    ("a", node("tag_a", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
    ("d", node("tag_d", [], [])),
  ]
  let new = [
    ("b", node("tag_b", [], [])),
    ("x", node("tag_x", [], [])),
    ("y", node("tag_y", [], [])),
    ("d", node("tag_d", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|Remove(0)
      #|Replace(1, Node(tag_x))
      #|InsertBefore(2, Node(tag_y))
      #|
    ,
  )
}

test "i_ii_match_2" {
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

test "1_2_i_ii" {
  let old = [("a", node("tag_a", [], []))]
  let new = [
    ("b", node("tag_b", [], [])),
    ("a", node("tag_a", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|InsertBefore(0, Node(tag_b))
      #|Append(1 ["Node(tag_c)"])
      #|
    ,
  )
}

test "1_2_i_i" {
  let old = [("a", node("tag_a", [], []))]
  let new = [
    ("a", node("tag_a", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|Append(2 ["Node(tag_b)", "Node(tag_c)"])
      #|
    ,
  )
}

test "2_1_i_i" {
  let old = [
    ("a", node("tag_a", [], [])),
    ("b", node("tag_b", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let new = [("a", node("tag_a", [], []))]
  let patches = diff_with_key(old, new)
  inspect!(
    String::concat(patches.map(patch_to_string)),
    content=
      #|Drop(1, 2)
      #|
    ,
  )
}

test "2_1_i_ii" {
  let old = [
    ("b", node("tag_b", [], [])),
    ("a", node("tag_a", [], [])),
    ("c", node("tag_c", [], [])),
  ]
  let new = [("a", node("tag_a", [], []))]
  let patches = diff_with_key(old, new)
  inspect!(String::concat(patches.map(patch_to_string)), content=
    #|Remove(0)
    #|Drop(1, 1)
    #|
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
