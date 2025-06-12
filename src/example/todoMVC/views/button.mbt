///|
pub fn[M] button(text : String, href? : String, click? : M) -> @html.Html[M] {
  let button_style = [
    "background: pink", "border-radius: 10px", "width:80px", "padding:20px", "margin:10px",
  ]
  let content = [@html.text(text)]
  match (href, click) {
    (Some(href), _) => @html.a(style=button_style, href~, content)
    (_, Some(click)) => @html.div(style=button_style, click~, content)
    _ => @html.div(style=button_style, content)
  }
}
