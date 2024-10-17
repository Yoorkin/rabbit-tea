pub fn startup[Model, Message](
  ~model : Model,
  ~update : (Message, Model) -> Model,
  ~view : (Model) -> @html.Html[Message]
) -> Unit {
  let mut sandbox = None
  fn after_update(html : @html.Html[Message]) {
    html.to_virtual_dom(sandbox.unwrap()).patch(sandbox.unwrap())
  }

  sandbox = Some(@adapter.new(model, update, view, ~after_update))
  sandbox.unwrap().refersh()
}
