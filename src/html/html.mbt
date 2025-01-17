///| TODO: struct creation should pop up a completion of labels
pub type Html[Msg] @vdom.Node[Msg]

///| Convert msg type of Html.
/// 
/// This is a expensive operation and should be used rarely.
pub fn map[A, B](self : Html[A], f : (A) -> B) -> Html[B] {
  self._.map(f)
}

///|
pub fn to_virtual_dom[Msg, Model, View](
  self : Html[Msg],
  sandbox : @adapter.Sandbox[Msg, Model, View]
) -> @vdom.Node[Msg] {
  @vdom.node("div", [], self._.to_virtual_dom_map(fn(x) { x }))
}

///|
fn Html::new[Msg](
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
    Some(style) =>
      attrs.push(attribute("style", String::concat(style, separator=";")))
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

///| Represents a fragment of elements, useful for grouping elements without adding an extra div
pub fn fragment[M](childrens : Array[Html[M]]) -> Html[M] {
  @vdom.fragment(childrens.map(fn(x) { x._ }))
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

///|
pub fn a[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  href~ : String,
  target~ : Target = Self,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("a", { "href": href }, style~, class?, id?, childrens, attributes=[
    attribute("target", target.to_string()),
  ])
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
pub fn ol[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("ol", {}, style~, class?, id?, childrens)
}

///|
pub fn li[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("li", {}, style~, class?, id?, childrens, events={
    "click": click.map(fn(m) { m }),
  })
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
      "width": width.map(Int::to_string),
      "height": height.map(Int::to_string),
      "border": border.map(Int::to_string),
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
      "width": width.map(Int::to_string),
      "height": height.map(Int::to_string),
    },
    [],
  )
}

///|
pub fn canvas[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  width? : Int,
  height? : Int
) -> Html[M] {
  new(
    "canvas",
    {},
    style~,
    class?,
    id?,
    optional_attrs={
      "width": width.map(Int::to_string),
      "height": height.map(Int::to_string),
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
  children : Array[Html[M]]
) -> Html[M] {
  new(
    "form",
    {},
    style~,
    id?,
    class?,
    optional_attrs={ "action": action },
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
  read_only? : Bool,
  multiple? : Bool,
  accept? : String,
  placeholder? : String,
  auto_complete? : AutoComplete,
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  childrens~ : Array[Html[M]] = [],
  change? : (String) -> M
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
      "readonly": read_only.map(Bool::to_string),
      "multiple": multiple.map(Bool::to_string),
      "accept": accept,
      "placeholder": placeholder,
    },
    optional_attributes=[change.map(on_change)],
    style~,
    class?,
    childrens,
  )
}
