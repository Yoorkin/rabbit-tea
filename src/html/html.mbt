///|
type T[Msg] @vdom.Node[Msg]

///|
pub typealias Html[Msg] = T[Msg]

///| Convert msg type of Html.
/// 
/// This is a expensive operation and should be used rarely.
pub fn map[A, B](self : Html[A], f : (A) -> B) -> Html[B] {
  self._.map(f)
}

///|
pub fn to_virtual_dom[Msg](self : Html[Msg]) -> @vdom.Node[Msg] {
  // Wrap the node with a root node. This node represents the root of the real DOM managed by TEA.
  node("root", [], [self])._
}

///| NOTE: This helper function is deprecated. Use `node` instead.
fn new[Msg](
  tag : String,
  attrs : Map[String, String],
  style? : Array[String],
  class? : String,
  id? : String,
  optional_attrs~ : Map[String, String?] = {},
  attributes~ : Array[Attribute[Msg]] = [],
  optional_attributes~ : Array[Attribute[Msg]?] = [],
  events~ : Map[String, Msg?] = {},
  childrens : Array[Html[Msg]]
) -> Html[Msg] {
  let attrs = attrs.to_array().map(fn(p) { attribute(p.0, p.1) })
  attrs.push_iter(attributes.iter())
  optional_attributes.each(fn {
    Some(attr) => attrs.push(attr)
    None => ()
  })
  optional_attrs.each(fn {
    k, Some(v) => attrs.push(attribute(k, v))
    _, None => ()
  })
  match style {
    Some(style) => attrs.push(attribute("style", style.join(";")))
    None => ()
  }
  match class {
    Some(class) => attrs.push(attribute("class", class))
    None => ()
  }
  match id {
    Some(id) => attrs.push(attribute("id", id))
    None => ()
  }
  events.each(fn {
    k, Some(v) => attrs.push(@vdom.on(k, Normal(v)))
    _, None => ()
  })
  node(tag, attrs, childrens)
}

///| 
pub fn node[Msg](
  tag : String,
  attributes : Array[Attribute[Msg]],
  childrens : Array[Html[Msg]]
) -> Html[Msg] {
  @vdom.node(tag, attributes.map(fn(x) { x._ }), childrens.map(fn(x) { x._ }))
}

///| Represents an empty element
pub fn nothing[M]() -> Html[M] {
  @vdom.nothing()
}

///|
pub fn button[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "button",
    {},
    style~,
    class?,
    id?,
    events={ "click": click.map(fn(m) { m }) },
    childrens,
  )
}

///|
pub fn h1[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h1", {}, style~, class?, id?, childrens)
}

///|
pub fn h2[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h2", {}, style~, class?, id?, childrens)
}

///|
pub fn h3[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h3", {}, style~, class?, id?, childrens)
}

///|
pub fn h4[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h4", {}, style~, class?, id?, childrens)
}

///|
pub fn h5[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h5", {}, style~, class?, id?, childrens)
}

///|
pub fn h6[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h6", {}, style~, class?, id?, childrens)
}

// ------ grouping content ------

///|
pub fn div[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "div",
    {},
    style~,
    class?,
    id?,
    events={ "click": click.map(fn(m) { m }) },
    childrens,
  )
}

///|
pub fn p[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("p", {}, style~, class?, id?, childrens)
}

///|
pub fn hr[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens~ : Array[Html[M]] = []
) -> Html[M] {
  new("hr", {}, style~, class?, id?, childrens)
}

///|
pub fn pre[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("pre", {}, style~, class?, id?, childrens)
}

///|
pub fn blockquote[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("blockquote", {}, style~, class?, id?, childrens)
}

///|
pub fn section[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("section", {}, style~, class?, id?, childrens)
}

// ---- text ----

///|
pub fn span[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("span", {}, style~, class?, id?, childrens)
}

///| Create `a` element.
/// 
/// The `escape` parameter is an optional boolean that determines whether the link 
/// should be escaped. By default, it is set to `false`. 
/// 
/// When `escape` is set to `true`, clicking the escaped link will cause the browser 
/// to immediately navigate to the `href` target, bypassing any interception logic. 
/// As a result, the `UrlRequest` message will not be triggered.
pub fn a[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  href~ : String,
  target~ : Target = Self,
  childrens : Array[Html[M]],
  escape~ : Bool = false
) -> Html[M] {
  let attrs = [
    @vdom.attribute("href", href),
    @vdom.attribute("target", target.to_string()),
  ]
  if style.length() > 0 {
    attrs.push(@vdom.attribute("style", style.join(";")))
  }
  if class is Some(class) {
    attrs.push(@vdom.attribute("class", class))
  }
  if id is Some(id) {
    attrs.push(@vdom.attribute("id", id))
  }
  @vdom.link(attrs, childrens.map(fn(x) { x._ }), escape~)
}

///|
pub fn code[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("code", {}, style~, class?, id?, childrens)
}

///|
pub fn em[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("em", {}, style~, class?, id?, childrens)
}

///|
pub fn strong[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("strong", {}, style~, class?, id?, childrens)
}

///|
pub fn i[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("i", {}, style~, class?, id?, childrens)
}

///|
pub fn b[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("b", {}, style~, class?, id?, childrens)
}

///|
pub fn u[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("u", {}, style~, class?, id?, childrens)
}

///|
pub fn sub[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("sub", {}, style~, class?, id?, childrens)
}

///|
pub fn sup[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("sup", {}, style~, class?, id?, childrens)
}

///|
pub fn text[Msg](str : String) -> Html[Msg] {
  @vdom.text(str)
}

// ---- lists ----

///|
pub fn ul[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("ul", {}, style~, class?, id?, childrens, events={
    "click": click.map(fn(m) { m }),
  })
}

///|
/// Notice that the `type` attribute for `ol` is not important for the browser now.
/// If you want to change the type of the list, you should use the `list-style-type` property in CSS.
pub fn ol[M](
  style~ : Array[String] = [],
  reversed? : Bool,
  start? : Int,
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "ol",
    {},
    style~,
    class?,
    id?,
    optional_attrs={
      "reversed": reversed.map(Bool::to_string),
      "start": start.map(fn(n) { n.to_string() }),
    },
    childrens,
  )
}

///|
pub fn li[M](
  style~ : Array[String] = [],
  value? : Int,
  id? : String,
  class? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "li",
    {},
    style~,
    class?,
    id?,
    optional_attrs={ "value": value.map(fn(n) { n.to_string() }) },
    childrens,
    events={ "click": click.map(fn(m) { m }) },
  )
}

///|
pub fn dl[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("dl", {}, style~, class?, id?, childrens)
}

///|
pub fn dt[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("dt", {}, style~, class?, id?, childrens)
}

///|
pub fn dd[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("dd", {}, style~, class?, id?, childrens)
}

// ---- embbded content ----

///|
pub fn img[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  src? : String,
  alt? : String,
  title? : String,
  width? : Int,
  height? : Int,
  border? : Int,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "img",
    {},
    style~,
    class?,
    id?,
    optional_attrs={
      "src": src,
      "alt": alt,
      "title": title,
      "width": width.map(fn(x) { x.to_string() }),
      "height": height.map(fn(x) { x.to_string() }),
      "border": border.map(fn(x) { x.to_string() }),
    },
    childrens,
  )
}

///|
pub fn iframe[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  src? : String,
  title? : String,
  width? : Int,
  height? : Int
) -> Html[M] {
  new(
    "iframe",
    {},
    style~,
    class?,
    id?,
    optional_attrs={
      "src": src,
      "title": title,
      "width": width.map(fn(x) { x.to_string() }),
      "height": height.map(fn(x) { x.to_string() }),
    },
    [],
  )
}

// ---- inputs ----

///|
pub fn br[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String
) -> Html[M] {
  new("br", {}, style~, class?, id?, [])
}

///|
pub(all) enum InputType {
  Button
  Checkbox
  Color
  Date
  DateTimeLocal
  Email
  File
  Hidden
  Image
  Month
  Number
  Password
  Radio
  Range
  Reset
  Search
  Submit
  Tel
  Text
  Time
  Url
  Week
}

///|
pub(all) enum AutoComplete {
  On
  Off
}

///|
pub fn form[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  action? : String,
  name? : String,
  children : Array[Html[M]]
) -> Html[M] {
  new(
    "form",
    {},
    style~,
    id?,
    class?,
    optional_attrs={ "action": action, "name": name },
    children,
  )
}

///|
pub fn label[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  for_? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "label",
    {},
    optional_attrs={ "for": for_ },
    style~,
    class?,
    id?,
    childrens,
  )
}

///|
pub fn input[M](
  input_type~ : InputType = Text,
  name? : String,
  value? : String,
  checked? : Bool,
  read_only? : Bool,
  multiple? : Bool,
  accept? : String,
  placeholder? : String,
  auto_complete? : AutoComplete,
  style~ : Array[String] = [],
  max? : Int,
  min? : Int,
  step? : Int,
  maxlength? : Int,
  minlength? : Int,
  pattern? : String,
  size? : Int,
  width? : Int,
  height? : Int,
  id? : String,
  class? : String,
  childrens~ : Array[Html[M]] = [],
  change? : (String) -> M,
  input? : (String) -> M
) -> Html[M] {
  let input_type = match input_type {
    Button => "button"
    Checkbox => "checkbox"
    Color => "color"
    Date => "date"
    DateTimeLocal => "datetime-local"
    Email => "email"
    File => "file"
    Hidden => "hidden"
    Image => "image"
    Month => "month"
    Number => "number"
    Password => "password"
    Radio => "radio"
    Range => "range"
    Reset => "reset"
    Search => "search"
    Submit => "submit"
    Tel => "tel"
    Text => "text"
    Time => "time"
    Url => "url"
    Week => "week"
  }
  let auto_complete = match auto_complete {
    Some(On) => "on"
    _ => "off"
  }
  new(
    "input",
    { "type": input_type, "autocomplete": auto_complete },
    optional_attrs={
      "name": name,
      "value": value,
      "checked": checked.map(Bool::to_string),
      "readonly": read_only.map(Bool::to_string),
      "multiple": multiple.map(Bool::to_string),
      "accept": accept,
      "max": max.map(fn(n) { n.to_string() }),
      "min": min.map(fn(n) { n.to_string() }),
      "step": step.map(fn(n) { n.to_string() }),
      "maxlength": maxlength.map(fn(n) { n.to_string() }),
      "minlength": minlength.map(fn(n) { n.to_string() }),
      "pattern": pattern,
      "size": size.map(fn(n) { n.to_string() }),
      "width": width.map(fn(n) { n.to_string() }),
      "height": height.map(fn(n) { n.to_string() }),
      "placeholder": placeholder,
    },
    optional_attributes=[change.map(on_change), input.map(on_input)],
    style~,
    id?,
    class?,
    childrens,
  )
}

///|
pub fn select[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  name? : String,
  change? : (String) -> M,
  childrens : Array[Html[M]]
) -> Html[M] {
  // TODO: support more attribute for select tag
  let attrs = []
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
  if id is Some(id) {
    attrs.push(attribute("id", id))
  }
  if class is Some(class) {
    attrs.push(attribute("class", class))
  }
  if disabled is Some(value) {
    attrs.push(property("disabled", Boolean(value)))
  }
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  if change is Some(to_msg) {
    attrs.push(on_change(to_msg))
  }
  node("select", attrs, childrens)
}

///|
pub fn option[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  value? : String,
  selected~ : Bool = false,
  childrens : Array[Html[M]]
) -> Html[M] {
  // TODO: support more attribute for option tag

  let attrs = []
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
  if id is Some(id) {
    attrs.push(attribute("id", id))
  }
  if class is Some(class) {
    attrs.push(attribute("class", class))
  }
  if disabled is Some(value) {
    attrs.push(property("disabled", Boolean(value)))
  }
  if value is Some(value) {
    attrs.push(attribute("value", value))
  }
  attrs.push(property("selected", Boolean(selected)))
  node("option", attrs, childrens)
}

///|
pub fn external[Msg](
  node : @dom.Node,
  attrs : Ref[Array[Attribute[Msg]]?],
  width~ : Int,
  height~ : Int
) -> Html[Msg] {
  let attrs = attrs.map(fn(opt) { opt.map(fn(arr) { arr.map(fn(a) { a._ }) }) })
  @vdom.external(node, attrs, width~, height~)
}

// table

///|
pub fn table[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("table", {}, style~, id?, class?, childrens)
}

///|
pub fn caption[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("caption", {}, style~, id?, class?, childrens)
}

///|
pub fn thead[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("thead", {}, style~, id?, class?, childrens)
}

///|
pub fn tbody[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("tbody", {}, style~, id?, class?, childrens)
}

///|
pub fn col[M](
  style~ : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "col",
    {},
    style~,
    id?,
    class?,
    optional_attrs={ "span": span.map(fn(n) { n.to_string() }) },
    childrens,
  )
}

///|
pub fn colgroup[M](
  style~ : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "colgroup",
    {},
    style~,
    id?,
    class?,
    optional_attrs={ "span": span.map(fn(n) { n.to_string() }) },
    childrens,
  )
}

///|
pub fn tr[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("tr", {}, style~, id?, class?, childrens)
}

///|
pub fn td[M](
  style~ : Array[String] = [],
  id? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "td",
    {},
    style~,
    id?,
    class?,
    optional_attrs={
      "colspan": colspan.map(fn(n) { n.to_string() }),
      "rowspan": rowspan.map(fn(n) { n.to_string() }),
      "headers": headers,
    },
    childrens,
  )
}

///|
pub(all) enum Scope {
  Row
  Col
  RowGroup
  ColGroup
}

///|
pub fn th[M](
  style~ : Array[String] = [],
  id? : String,
  abbr? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  scope? : Scope,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "th",
    {},
    style~,
    id?,
    class?,
    optional_attrs={
      "abbr": abbr,
      "colspan": colspan.map(fn(n) { n.to_string() }),
      "rowspan": rowspan.map(fn(n) { n.to_string() }),
      "headers": headers,
      "scope": scope.map(fn(s) {
        match s {
          Row => "row"
          Col => "col"
          RowGroup => "rowgroup"
          ColGroup => "colgroup"
        }
      }),
    },
    childrens,
  )
}

///|
pub fn tfoot[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("tfoot", {}, style~, id?, class?, childrens)
}
