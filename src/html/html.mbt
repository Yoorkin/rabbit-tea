///|
type T[Msg] @vdom.Node[Msg]

///|
pub typealias Html[Msg] = T[Msg]

///| Convert msg type of Html.
/// 
/// This is a expensive operation and should be used rarely.
pub fn[A, B] map(self : Html[A], f : (A) -> B) -> Html[B] {
  self._.map(f)
}

///|
pub fn[Msg] to_virtual_dom(self : Html[Msg]) -> @vdom.Node[Msg] {
  // Wrap the node with a root node. This node represents the root of the real DOM managed by TEA.
  node("root", [], [self])._
}

///| 
pub fn[Msg] node(
  tag : String,
  attributes : Array[Attribute[Msg]],
  childrens : Array[Html[Msg]]
) -> Html[Msg] {
  @vdom.node(tag, attributes.map(fn(x) { x._ }), childrens.map(fn(x) { x._ }))
}

///|
fn[Msg] common_node(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  tag : String,
  attributes : Array[Attribute[Msg]],
  childrens : Array[Html[Msg]]
) -> Html[Msg] {
  let attrs = []
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
  if klass is Some(klass) {
    attrs.push(attribute("class", klass))
  }
  if id is Some(id) {
    attrs.push(attribute("id", id))
  }
  node(tag, attributes + attrs, childrens)
}

///| Represents an empty element
pub fn[M] nothing() -> Html[M] {
  @vdom.nothing()
}

///|
pub fn[M] button(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(fn(_) { click }))
  }
  common_node(style~, klass?=klass, id?, "button", attrs, childrens)
}

///|
pub fn[M] h1(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "h1", [], childrens)
}

///|
pub fn[M] h2(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "h2", [], childrens)
}

///|
pub fn[M] h3(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "h3", [], childrens)
}

///|
pub fn[M] h4(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "h4", [], childrens)
}

///|
pub fn[M] h5(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "h5", [], childrens)
}

///|
pub fn[M] h6(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "h6", [], childrens)
}

// ------ grouping content ------

///|
pub fn[M] div(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(fn(_) { click }))
  }
  common_node(style~, klass?=klass, id?, "div", attrs, childrens)
}

///|
pub fn[M] p(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "p", [], childrens)
}

///|
pub fn[M] hr(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens~ : Array[Html[M]] = []
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "hr", [], childrens)
}

///|
pub fn[M] pre(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "pre", [], childrens)
}

///|
pub fn[M] blockquote(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "blockquote", [], childrens)
}

///|
pub fn[M] section(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "section", [], childrens)
}

// ---- text ----

///|
pub fn[M] span(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "span", [], childrens)
}

///| Create `a` element.
/// 
/// # Parameters
/// 
/// - `escape`: an optional boolean that determines whether the link 
///  should be escaped. By default, it is set to `false`. 
/// 
///   When `escape` is set to `true`, clicking the escaped link will cause the browser 
///   to immediately navigate to the `href` target, bypassing any interception logic. 
///   As a result, the `UrlRequest` message will not be triggered.
/// 
/// - `target`: an optional `Target` that specifies where to open the link.
/// 
/// If the user holds the `ctrl` key (or the command key on macOS) while clicking the link,
/// the click event will be handled by the browser, and the `UrlRequest` will not be triggered either.
pub fn[M] a(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
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
  if klass is Some(klass) {
    attrs.push(@vdom.attribute("class", klass))
  }
  if id is Some(id) {
    attrs.push(@vdom.attribute("id", id))
  }
  @vdom.link(attrs, childrens.map(fn(x) { x._ }), escape~)
}

///|
pub fn[M] code(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "code", [], childrens)
}

///|
pub fn[M] em(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "em", [], childrens)
}

///|
pub fn[M] strong(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "strong", [], childrens)
}

///|
pub fn[M] i(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "i", [], childrens)
}

///|
pub fn[M] b(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "b", [], childrens)
}

///|
pub fn[M] u(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "u", [], childrens)
}

///|
pub fn[M] sub(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "sub", [], childrens)
}

///|
pub fn[M] sup(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "sup", [], childrens)
}

///|
pub fn[Msg] text(str : String) -> Html[Msg] {
  @vdom.text(str)
}

// ---- lists ----

///|
pub fn[M] ul(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(fn(_) { click }))
  }
  common_node(style~, klass?=klass, id?, "ul", attrs, childrens)
}

///| Notice that the `type` attribute for `ol` is not important for the browser now.
/// If you want to change the type of the list, you should use the `list-style-type` property in CSS.
pub fn[M] ol(
  style~ : Array[String] = [],
  reversed? : Bool,
  start? : Int,
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if reversed is Some(reversed) {
    // TODO: test this attribute
    attrs.push(attribute("reversed", reversed.to_string()))
  }
  if start is Some(start) {
    // TODO: test this attribute
    attrs.push(attribute("start", start.to_string()))
  }
  common_node(style~, klass?=klass, id?, "ol", attrs, childrens)
}

///|
pub fn[M] li(
  style~ : Array[String] = [],
  value? : Int,
  id? : String,
  klass? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(fn(_) { click }))
  }
  if value is Some(value) {
    attrs.push(attribute("value", value.to_string()))
  }
  common_node(style~, klass?=klass, id?, "li", attrs, childrens)
}

///|
pub fn[M] dl(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "dl", [], childrens)
}

///|
pub fn[M] dt(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "dt", [], childrens)
}

///|
pub fn[M] dd(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "dd", [], childrens)
}

// ---- embbded content ----

///|
pub fn[M] img(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  src? : String,
  alt? : String,
  title? : String,
  width? : Int,
  height? : Int,
  border? : Int,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if src is Some(src) {
    attrs.push(attribute("src", src))
  }
  if alt is Some(alt) {
    attrs.push(attribute("alt", alt))
  }
  if title is Some(title) {
    attrs.push(attribute("title", title))
  }
  if width is Some(width) {
    attrs.push(attribute("width", width.to_string()))
  }
  if height is Some(height) {
    attrs.push(attribute("height", height.to_string()))
  }
  if border is Some(border) {
    attrs.push(attribute("border", border.to_string()))
  }
  common_node(style~, klass?=klass, id?, "img", attrs, childrens)
}

///|
pub fn[M] iframe(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  src? : String,
  title? : String,
  width? : Int,
  height? : Int
) -> Html[M] {
  let attrs = []
  if src is Some(src) {
    attrs.push(attribute("src", src))
  }
  if title is Some(title) {
    attrs.push(attribute("title", title))
  }
  if width is Some(width) {
    attrs.push(attribute("width", width.to_string()))
  }
  if height is Some(height) {
    attrs.push(attribute("height", height.to_string()))
  }
  common_node(style~, klass?=klass, id?, "iframe", attrs, [])
}

// ---- inputs ----

///|
pub fn[M] br(
  style~ : Array[String] = [],
  id? : String,
  klass? : String
) -> Html[M] {
  common_node(style~, klass?=klass, id?, "br", [], [])
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
pub fn[M] form(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  action? : String,
  name? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if action is Some(action) {
    attrs.push(attribute("action", action))
  }
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  common_node(style~, klass?=klass, id?, "form", attrs, childrens)
}

///|
pub fn[M] label(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  for_? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if for_ is Some(for_) {
    attrs.push(attribute("for", for_))
  }
  common_node(style~, klass?=klass, id?, "form", attrs, childrens)
}

///|
pub fn[M] input(
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
  klass? : String,
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
  let attrs = []
  attrs.push(attribute("type", input_type))
  attrs.push(attribute("autocomplete", auto_complete))
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  if value is Some(value) {
    attrs.push(property("value", String(value)))
  }
  if checked is Some(checked) {
    attrs.push(property("checked", Boolean(checked)))
  }
  if read_only is Some(read_only) {
    attrs.push(property("readonly", Boolean(read_only)))
  }
  if multiple is Some(multiple) {
    attrs.push(property("multiple", Boolean(multiple)))
  }
  if accept is Some(accept) {
    attrs.push(attribute("accept", accept))
  }
  if max is Some(max) {
    attrs.push(attribute("max", max.to_string()))
  }
  if min is Some(min) {
    attrs.push(attribute("min", min.to_string()))
  }
  if step is Some(step) {
    attrs.push(attribute("step", step.to_string()))
  }
  if maxlength is Some(maxlength) {
    attrs.push(attribute("maxlength", maxlength.to_string()))
  }
  if minlength is Some(minlength) {
    attrs.push(attribute("minlength", minlength.to_string()))
  }
  if pattern is Some(pattern) {
    attrs.push(attribute("pattern", pattern))
  }
  if size is Some(size) {
    attrs.push(attribute("size", size.to_string()))
  }
  if width is Some(width) {
    attrs.push(attribute("width", width.to_string()))
  }
  if height is Some(height) {
    attrs.push(attribute("height", height.to_string()))
  }
  if placeholder is Some(placeholder) {
    attrs.push(attribute("placeholder", placeholder))
  }
  if change is Some(to_msg) {
    attrs.push(on_change(to_msg))
  }
  if input is Some(to_msg) {
    attrs.push(on_input(to_msg))
  }
  common_node("input", attrs, childrens, style~, id?, klass?=klass)
}

///|
pub fn[M] select(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
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
  if klass is Some(klass) {
    attrs.push(attribute("class", klass))
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
pub fn[M] option(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
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
  if klass is Some(klass) {
    attrs.push(attribute("class", klass))
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
pub fn[Msg] external(
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
pub fn[M] table(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node("table", [], style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] caption(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node("caption", [], style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] thead(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node("thead", [], style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] tbody(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node("tbody", [], style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] col(
  style~ : Array[String] = [],
  id? : String,
  span? : Int,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if span is Some(span) {
    attrs.push(attribute("span", span.to_string()))
  }
  common_node("col", attrs, style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] colgroup(
  style~ : Array[String] = [],
  id? : String,
  span? : Int,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if span is Some(span) {
    attrs.push(attribute("span", span.to_string()))
  }
  common_node("colgroup", attrs, style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] tr(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node("tr", [], style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] td(
  style~ : Array[String] = [],
  id? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if colspan is Some(colspan) {
    attrs.push(attribute("colspan", colspan.to_string()))
  }
  if rowspan is Some(rowspan) {
    attrs.push(attribute("rowspan", rowspan.to_string()))
  }
  if headers is Some(headers) {
    attrs.push(attribute("headers", headers))
  }
  common_node("td", attrs, style~, id?, klass?=klass, childrens)
}

///|
pub(all) enum Scope {
  Row
  Col
  RowGroup
  ColGroup
}

///|
pub fn[M] th(
  style~ : Array[String] = [],
  id? : String,
  abbr? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  scope? : Scope,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if colspan is Some(colspan) {
    attrs.push(attribute("colspan", colspan.to_string()))
  }
  if rowspan is Some(rowspan) {
    attrs.push(attribute("rowspan", rowspan.to_string()))
  }
  if headers is Some(headers) {
    attrs.push(attribute("headers", headers))
  }
  if abbr is Some(abbr) {
    attrs.push(attribute("abbr", abbr))
  }
  if scope is Some(scope) {
    attrs.push(
      attribute(
        "scope",
        match scope {
          Row => "row"
          Col => "col"
          RowGroup => "rowgroup"
          ColGroup => "colgroup"
        },
      ),
    )
  }
  common_node("th", attrs, style~, id?, klass?=klass, childrens)
}

///|
pub fn[M] tfoot(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  common_node("tfoot", [], style~, id?, klass?=klass, childrens)
}

///| Dialog element. 
/// 
/// Hint: You can use the `show` and `close` commands in the `@dialog` package
/// to manipulate the dialog.
///
/// # Attributes
/// 
/// - `open`: indicates whether the dialog is open or closed by default.
/// 
/// # Messages
/// 
/// - `close`: triggered when the dialog is closed. 
///   
///   The string payload of the `close` message is the return value of the dialog.
/// 
/// - `cancel`: triggered when the user instructs the browser that they wish to 
///   dismiss the current open dialog.
/// 
///   It can be triggered when the user presses `esc` or uses the `request_close` command.
/// 
///   If the `cancel` argument is provided, **the dialog will not close automatically** 
///   after this message is triggered. You can use the `@dialog.close` command 
///   to close it or `@cmd.none` to keep it open.
/// 
/// # Example
/// 
/// ```
/// typealias Model = String
/// 
/// enum Msg {
///   Open
///   Closed(String)
///   YesNo(Bool)
/// }
/// 
/// fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
///   match msg {
///     Open => (@dialog.show("confirm"), model)
///     YesNo(answer) => (@dialog.close("confirm", return_value=answer.to_string()), model) 
///     Closed(value) => (none(), value)
///   }
/// }
/// 
/// fn view(model : Model) -> Html[Msg] {
///   div([
///     h1([text(model)]),
///     button(click=Msg::Open, [text("open")]),
///     dialog(id="confirm", close=Msg::Closed, [
///       p([text("Are you sure?")]),
///       button(click=YesNo(true), [text("Yes")]),
///       button(click=YesNo(false), [text("No")]),
///     ]),
///   ])
/// }
/// ```
/// 
pub fn[M] dialog(
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  open? : Bool,
  close? : (String) -> M,
  cancel? : M,
  childrens : Array[Html[M]]
) -> Html[M] {
  let attrs = []
  if open is Some(open) {
    attrs.push(property("open", Boolean(open)))
  }
  if close is Some(close) {
    attrs.push(
      @vdom.on(
        "close",
        HandleEvent(fn(event) {
          let html_element = event
            .target()
            .to_node()
            .to_option()
            .unwrap()
            .to_element()
            .to_option()
            .unwrap()
            .to_html_element()
            .to_option()
            .unwrap()
            .to_html_dialog_element()
            .to_option()
            .unwrap()
          close(html_element.return_value())
        }),
      ),
    )
  }
  if cancel is Some(cancel) {
    attrs.push(
      @vdom.on(
        "cancel",
        HandleEvent(fn(event) {
          event.prevent_default()
          cancel
        }),
      ),
    )
  }
  common_node("dialog", attrs, style~, id?, klass?=klass, childrens)
}
