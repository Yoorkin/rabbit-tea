pub fn startup[Model, Message](
  ~model : Model,
  ~update : (Message, Model) -> Model,
  ~view : (Model) -> @html.Html[Message]
) -> Unit {
  fn after_update(html : @html.Html[Message]) {
    html.to_virtual_dom().patch()
  }
  @adapter.init_sandbox(model, update, view, ~after_update)
}
