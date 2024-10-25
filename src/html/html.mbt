/// TODO: struct creation should pop up a completion of labels

struct Html[M] {
  attrs : Map[String, String]
  tag : String
  childerns : Array[Html[M]]
  events : Map[String, (@adapter.Event) -> M]
}

pub fn map[A, B](self : Html[A], f : (A) -> B) -> Html[B] {
  let { attrs, tag, childerns, events } = self
  let childerns = childerns.map(fn(x) { x.map(f) })
  let events = events
    .iter()
    .map(fn { (name, callback) => (name, fn(e) { f(callback(e)) }) })
    .collect()
    |> Map::from_array
  { attrs, tag, childerns, events }
}

pub fn to_virtual_dom[Msg, Model, View](
  self : Html[Msg],
  sandbox : @adapter.Sandbox[Msg, Model, View]
) -> @vdom.Node {
  {
    tag: self.tag,
    attrs: self.attrs,
    childrens: self.childerns.map(fn(x) { x.to_virtual_dom(sandbox) }),
    events: self.events
    .iter()
    .map(fn { (k, v) => (k, fn(event) { sandbox.update(v(event)) }) })
    .collect()
    |> Map::from_array,
  }
}

fn Html::new[M](
  tag : String,
  attrs : Map[String, String],
  ~style? : Array[String],
  ~class? : String,
  ~id? : String,
  ~optional_attrs : Map[String, String?] = {},
  ~events : Map[String, ((@adapter.Event) -> M)?] = {},
  childerns : Array[Html[M]]
) -> Html[M] {
  optional_attrs["style"] = style.map(fn(x) { concat(x, separator=";") })
  optional_attrs["class"] = class
  optional_attrs.each(
    fn(k, v) {
      match v {
        Some(v) => attrs[k] = v
        None => ()
      }
    },
  )
  match id {
    Some(id) => attrs["id"] = id
    None => ()
  }
  let events = events
    .iter()
    .fold(
      init={},
      fn {
        acc, (k, Some(v)) => acc..op_set(k, v)
        acc, (_, None) => acc
      },
    )
  { attrs, tag, childerns, events }
}

pub fn br[M]() -> Html[M] {
  new("br", {}, [])
}

fn concat(strings : Array[String], ~separator : String = "") -> String {
  let buf = Buffer::new()
  if separator == "" {
    for s in strings {
      buf.write_string(s)
    }
  } else {
    match strings {
      [] => ()
      [hd, .. as tl] => {
        buf.write_string(hd)
        for s in tl {
          buf.write_string(separator)
          buf.write_string(s)
        }
      }
    }
  }
  buf.to_string()
}

pub fn button[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~click? : M,
  childerns : Array[Html[M]]
) -> Html[M] {
  new(
    "button",
    {},
    ~style,
    ~class?,
    ~id?,
    events={ "click": click.map(fn(m) { fn(_event) { m } }) },
    childerns,
  )
}

pub fn h1[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h1", {}, ~style, ~class?, ~id?, childrens)
}

pub fn h2[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h2", {}, ~style, ~class?, ~id?, childrens)
}

pub fn h3[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h3", {}, ~style, ~class?, ~id?, childrens)
}

pub fn h4[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h4", {}, ~style, ~class?, ~id?, childrens)
}

pub fn h5[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h5", {}, ~style, ~class?, ~id?, childrens)
}

pub fn h6[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("h6", {}, ~style, ~class?, ~id?, childrens)
}

pub fn p[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new("p", {}, ~style, ~class?, ~id?, childrens)
}

pub enum Target {
  Self
  Blank
}

pub fn a[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~href : String,
  ~target : Target = Self,
  childrens : Array[Html[M]]
) -> Html[M] {
  let target = match target {
    Self => "_self"
    Blank => "_blank"
  }
  new("a", { "target": target, "href": href }, ~style, ~class?, ~id?, childrens)
}

pub fn img[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~src? : String,
  ~alt? : String,
  ~title? : String,
  ~width? : Int,
  ~height? : Int,
  ~border? : Int,
  childerns : Array[Html[M]]
) -> Html[M] {
  new(
    "img",
    {},
    ~style,
    ~class?,
    ~id?,
    optional_attrs={
      "src": src,
      "alt": alt,
      "title": title,
      "width": width.map(Int::to_string),
      "height": height.map(Int::to_string),
      "border": border.map(Int::to_string),
    },
    childerns,
  )
}

pub fn div[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~click? : M,
  childerns : Array[Html[M]]
) -> Html[M] {
  new(
    "div",
    {},
    ~style,
    ~class?,
    ~id?,
    events={ "click": click.map(fn(m) { fn(_event) { m } }) },
    childerns,
  )
}

pub fn ul[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childerns : Array[Html[M]]
) -> Html[M] {
  new("ul", {}, ~style, ~class?, ~id?, childerns)
}

pub fn ol[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childerns : Array[Html[M]]
) -> Html[M] {
  new("ol", {}, ~style, ~class?, ~id?, childerns)
}

pub fn li[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  childerns : Array[Html[M]]
) -> Html[M] {
  new("ol", {}, ~style, ~class?, ~id?, childerns)
}

pub fn text[M](str : String) -> Html[M] {
  new("plain-text", { "value": str }, [])
}

pub enum InputType {
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

pub enum AutoComplete {
  On
  Off
}

pub fn form[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~action? : String,
  childern : Array[Html[M]]
) -> Html[M] {
  new(
    "form",
    {},
    ~style,
    ~id?,
    ~class?,
    optional_attrs={ "action": action },
    childern,
  )
}

pub fn label[M](
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~for_? : String,
  childrens : Array[Html[M]]
) -> Html[M] {
  new(
    "label",
    {},
    optional_attrs={ "for": for_ },
    ~style,
    ~class?,
    ~id?,
    childrens,
  )
}

pub fn input[M](
  ~input_type : InputType = Text,
  ~name? : String,
  ~value? : String,
  ~read_only? : Bool,
  ~multiple? : Bool,
  ~accept? : String,
  ~auto_complete? : AutoComplete,
  ~style : Array[String] = [],
  ~id? : String,
  ~class? : String,
  ~childerns : Array[Html[M]] = [],
  ~change? : (String) -> M
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
    },
    events={
      "change": change.map(fn(m) { fn(event) { m(event.target().value()) } }),
    },
    ~style,
    ~class?,
    childerns,
  )
}
