///|
type Attribute[Msg] @vdom.Attribute[Msg]

///| Specify an style
pub fn[Msg] style(key : String, value : String) -> Attribute[Msg] {
  @vdom.style(key, value)
}

///|
pub fn[Msg] attribute(key : String, value : String) -> Attribute[Msg] {
  @vdom.attribute(key, value)
}

///|
pub fn[M] property(key : String, value : @variant.Variant) -> Attribute[M] {
  @vdom.property(key, value)
}

///|
pub fn[Msg] href(value : String) -> Attribute[Msg] {
  // Note: `href` will be the value you specified, but by property, the value 
  // will be resolved to an absolute URL.
  @vdom.property("href", @variant.String(value))
}

///|
pub(all) enum Target {
  Self
  Blank
}

///|
fn to_string(self : Target) -> String {
  match self {
    Self => "_self"
    Blank => "_blank"
  }
}

///|
pub fn[Msg] target(value : Target) -> Attribute[Msg] {
  @vdom.attribute("target", value.to_string())
}
