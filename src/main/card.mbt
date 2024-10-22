enum CardModel {
  TitleCard(~title : String, ~content : String, ~id : Int)
  Card(String, ~id : Int)
}

fn id(self : CardModel) -> Int {
  match self {
    TitleCard(~title, ~content, ~id) => id
    Card(_, ~id) => id
  }
}

fn view_card(model : CardModel) -> @html.Html[Message] {
  let (elements, id) = match model {
    TitleCard(~title, ~content, ~id) =>
      ([@html.h1([@html.text(title)]), @html.p([@html.text(content)])], id)
    Card(content, ~id) => ([@html.p([@html.text(content)])], id)
  }
  @html.div(
    style=[
      @css.shadow, @css.border_solid, @css.border_1, @css.border_gray_200, @css.p_5,
      @css.rounded_lg, @css.m_2, @css.bg_white,
    ],
    elements,
    click=EditCard(id),
  )
}
