///|
type Attribute[Msg] @vdom.Attribute[Msg]

///| Specify an style
pub fn style[Msg](key : String, value : String) -> Attribute[Msg] {
  @vdom.style(key, value)
}

///|
pub fn attribute[Msg](key : String, value : String) -> Attribute[Msg] {
  @vdom.attribute(key, value)
}

///|
pub fn href[Msg](value : String) -> Attribute[Msg] {
  // Note: `href` will be the value you specified, but by property, the value 
  // will be resolved to an absolute URL.
  @vdom.property("href", value)
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
pub fn target[Msg](value : Target) -> Attribute[Msg] {
  @vdom.attribute("target", value.to_string())
}
