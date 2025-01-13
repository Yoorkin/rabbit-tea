///|
enum Model {
  Loading
  Failed
  Editing(Card)
}

///|
struct Card {
  title : String
  content : String
  id : Int?
} derive(Show)

///|
enum Msg {
  TitleChanged(String)
  ContentChanged(String)
  GotCardData(Result[Json, String])
  SaveCardAndExit(Card)
  ReqResult(Result[Json, String])
} derive(Show)

///|
pub fn load(index : Int?) -> (@tea.Command[Msg], Model) {
  match index {
    None => (@tea.none(), Editing({ title: "", content: "", id: None }))
    Some(index) =>
      (@http.get("/api/cards/\{index}", expect=Json(Msg::GotCardData)), Loading)
  }
}

///|
pub fn update(msg : Msg, model : Model) -> (@tea.Command[Msg], Model) {
  match (msg, model) {
    (GotCardData(res), _) =>
      match res {
        Ok(
          {
            "title": String(title),
            "content": String(content),
            "id": Number(id),
          }
        ) => (@tea.none(), Editing({ title, content, id: Some(id.to_int()) }))
        _ => (@tea.none(), Failed)
      }
    (TitleChanged(title), Editing(card)) =>
      (@tea.none(), Editing({ ..card, title, }))
    (ContentChanged(content), Editing(card)) =>
      (@tea.none(), Editing({ ..card, content, }))
    (SaveCardAndExit(card), _) => {
      let save = match card.id {
        Some(id) =>
          if card.title == "" && card.content == "" {
            @http.delete("/api/cards/\{id}", expect=Json(Msg::ReqResult))
          } else {
            @http.patch(
              "/api/cards/\{id}",
              Json({
                "title": card.title.to_json(),
                "content": card.content.to_json(),
                "id": id.to_json(),
              }),
              expect=Json(Msg::ReqResult),
            )
          }
        None =>
          @http.post(
            "/api/cards",
            Json({
              "title": String(card.title),
              "content": String(card.content),
            }),
            expect=Json(Msg::ReqResult),
          )
      }
      let exit = @browser.load("/")
      (@tea.batch([save, exit]), model)
    }
  }
}

///|
pub fn view(model : Model) -> @html.Html[Msg] {
  match model {
    Loading => @html.div([@html.text("Loading card...")])
    Failed => @html.div([@html.text("Failed to load card")])
    Editing({ title, content, id } as card) => {
      let title_text = match id {
        Some(_) => @html.text("Edit Todo")
        None => @html.text("New Todo")
      }
      @html.div(
        style=[
          "display: flex", "flex-direction: column", "width: 500px", "height: 100%",
        ],
        [
          @html.h1([title_text]),
          view_text_input("title", title, change=Msg::TitleChanged),
          view_text_input("content", content, change=Msg::ContentChanged),
          @views.button("close", click=Msg::SaveCardAndExit(card)),
        ],
      )
    }
  }
}

///|
fn view_text_input[M](
  label : String,
  value : String,
  change~ : (String) -> M
) -> @html.Html[M] {
  @html.div([
    @html.label([
      @html.text(label),
      @html.input(
        style=[
          "border: 1px solid #ccc", "border-radius: 5px", "padding: 5px", "margin: 10px",
          "width: 500px",
        ],
        value~,
        input_type=Text,
        change~,
      ),
    ]),
  ])
}
