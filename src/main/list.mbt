typealias ListModel = Array[CardModel]

fn view_list(model : ListModel) -> @html.Html[Message] {
  @html.div(
    style=[
      "display: flex", "flex-direction: column", "width: 500px", "height: 100%",
    ],
    model.map(view_card),
  )
}
