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
  inspect!(String::concat(patches.map(patch_to_string)), content=
    #|Remove(0)
    #|InsertBefore(2, Node)
    #|
  )
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
      Replace(index, _) =>
        indent_str + "Replace(" + index.to_string() + ", Node)\n"
      InsertBefore(index, _) =>
        indent_str + "InsertBefore(" + index.to_string() + ", Node)\n"
      Append(nodes) =>
        indent_str + "Append(" + nodes.length().to_string() + " nodes)\n"
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
