///|
enum CardModel {
  TitleCard(title~ : String, content~ : String, id~ : Int)
  Card(String, id~ : Int)
} derive(Show)

///|
fn id(self : CardModel) -> Int {
  match self {
    TitleCard(id~, ..) => id
    Card(_, id~) => id
  }
}

///|
fn view_card[Msg](model : CardModel) -> @html.Html[Msg] {
  let (content, id) = match model {
    TitleCard(title~, content~, id~) =>
      ([@html.h1([@html.text(title)]), @html.p([@html.text(content)])], id)
    Card(content, id~) => ([@html.p([@html.text(content)])], id)
  }
  @html.a(
    href="cards/\{id}",
    style=[
      "box-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05)", "border-style: solid", "border-width: 1px",
      "border-color: #e5e7eb", "padding: 1.25rem", "border-radius: 0.5rem", "margin: 0.5rem",
      "background-color: #fff",
    ],
    content,
  )
}
