enum Message {
  Increment
  Decrement
  Reset
  Mark
} derive(Show)

enum CardModel {
  PictureCard(~title : String, ~content : String, ~img_url : String)
  CardWithTitle(~title : String, ~content : String)
  Card(String)
}

struct Model {
  cards : Array[CardModel]
  count : Int
}

fn update(msg : Message, model : Model) -> Model {
  match msg {
    Increment => { ..model, count: model.count + 1 }
    Decrement => { ..model, count: model.count - 1 }
    Reset => { ..model, count: 0, cards: [] }
    Mark =>
      {
        ..model,
        cards: [
          ..model.cards,
          CardWithTitle(
            title="Mark",
            content="You have clicked \{model.count} times",
          ),
        ],
      }
  }
}

let button_style = [
  "background: pink", "border-radius: 10px", "width:100px", "height:40px", "padding:20px",
  "margin:10px",
]

fn main {
  @tea.startup(
    model={
      count: 0,
      cards: [
        Card("hello note"),
        CardWithTitle(
          title="Programming in MoonBit",
          content="things to do 1. blablabla 2.blablabla 3.blabla ....",
        ),
        Card("42"),
      ],
    },
    ~update,
    ~view,
  )
}

fn card_view(card : CardModel) -> @html.Html[Message] {
  let elements = match card {
    PictureCard(~title, ~content, ~img_url) => ...
    CardWithTitle(~title, ~content) =>
      [@html.h1([@html.text(title)]), @html.p([@html.text(content)])]
    Card(content) => [@html.p([@html.text(content)])]
  }
  @html.div(
    style=[
      @css.shadow, @css.border_solid, @css.border_1, @css.border_gray_200, @css.p_5,
      @css.rounded_lg, @css.m_2, @css.bg_white,
    ],
    elements,
  )
}

fn view(model : Model) -> @html.Html[Message] {
  let { cards, .. } = model
  @html.div(
    style=["display:flex", "flex-direction:column"],
    [
      @html.h1([@html.text("You have clicked \{model.count} times")]),
      @html.div(
        style=[
          "display: flex", "width: 500px", "height: 100%",
        ],
        [
          @html.div(style=button_style, [@html.text("+ 1")], click=Increment),
          @html.div(style=button_style, [@html.text("- 1")], click=Decrement),
          @html.div(style=button_style, [@html.text("reset")], click=Reset),
          @html.div(style=button_style, [@html.text("mark")], click=Mark),
        ],
      ),
      @html.div(
        style=[
          "display: flex", "flex-direction: column", "width: 500px",
          "height: 100%",
        ],
        cards.map(card_view),
      ),
    ],
  )
}
