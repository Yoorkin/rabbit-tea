///|
pub enum Msg {
  DeleteAll
  GotCardsData(Result[Array[CardModel], String])
  ReqResult(Result[Json, String])
} derive(Show)

///|
pub struct Model {
  cards : Array[CardModel]
} derive(Show)

///|
pub fn load() -> (@tea.Command[Msg], Model) {
  (
    @http.get("/api/cards", expect=Json(Msg::GotCardsData, decode_cards)),
    { cards: [] },
  )
}

///|
pub fn view(model : Model) -> @html.Html[Msg] {
  @html.div_keyed(
    style=["p-0", "display:flex", "flex-direction:column"],
    [
      ("title", @html.h1([@html.text("MoonBit TodoMVC")])),
      ("buttons", @html.div(style=["display: flex", "width: 500px", "height: 100%"], [
        @views.button("clear", click=DeleteAll),
        @views.button("+", href="/new"),
      ])),
      ("text", @html.p([@html.text("Click cards below to edit, click + to add a new card")])),
      ("list", view_list(model.cards)),
    ],
  )
}

///|
pub fn update(msg : Msg, model : Model) -> (@tea.Command[Msg], Model) {
  match msg {
    DeleteAll => {
      let cmds = @tea.batch(
        [
          ..model.cards.map(fn(card) {
            @http.delete(
              "/api/cards/\{card.id()}",
              expect=Json(Msg::ReqResult, Result::Ok),
            )
          }),
          @browser.push_url("/home"),
        ],
      )
      (cmds, model)
    }
    GotCardsData(res) =>
      match res {
        Ok(cards) => (@tea.none(), { cards, })
        Err(_) => (@tea.none(), { cards: [] })
      }
    ReqResult(_) => (@tea.none(), model)
  }
}

///|
fn decode_cards(json : Json) -> Result[Array[CardModel], String] {
  match json {
    { "cards": Array(elems) } => {
      let cards = elems.filter_map(fn {
        {
          "title"? : Some(String(""))
          | None,
          "content": String(content),
          "id": Number(id),
        } => Some(Card(content, id=id.to_int()))
        { "title": String(title), "content": String(content), "id": Number(id) } =>
          Some(TitleCard(title~, content~, id=id.to_int()))
        _ => None
      })
      Ok(cards)
    }
    _ => Err("Invalid cards data")
  }
}
