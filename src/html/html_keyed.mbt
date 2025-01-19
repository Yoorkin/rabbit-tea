///|
/// waiting for merge with Html::new
fn Html::new_keyed[Msg](
  tag : String,
  attrs : Map[String, String],
  style? : Array[String],
  class? : String,
  id? : String,
  optional_attrs~ : Map[String, String?] = {},
  attributes~ : Array[Attribute[Msg]] = [],
  optional_attributes~ : Array[Attribute[Msg]?] = [],
  events~ : Map[String, Msg?] = {},
  childrens : Array[(String, Html[Msg])]
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
  keyed_node(tag, attrs, childrens)
}

///|
pub fn keyed_node[Msg](
  key : String,
  attributes : Array[Attribute[Msg]],
  childrens : Array[(String, Html[Msg])]
) -> Html[Msg] {
  @vdom.keyed_node(
    key,
    attributes.map(fn(x) { x._ }),
    childrens.map(fn(x) { (x.0, x.1._) }),
  )
}

///|
pub fn div_keyed[M](
  style~ : Array[String] = [],
  id? : String,
  class? : String,
  click? : M,
  childrens : Array[(String, Html[M])]
) -> Html[M] {
  new_keyed(
    "div",
    {},
    style~,
    class?,
    id?,
    events={ "click": click.map(fn(m) { m }) },
    childrens,
  )
}
