///|
typealias Array[CardModel] as ListModel

///|
fn[A] view_list(model : ListModel) -> @html.Html[A] {
  @html.div(
    style=[
      "display: flex", "flex-direction: column", "width: 500px", "height: 100%",
    ],
    model.map(view_card),
  )
}
