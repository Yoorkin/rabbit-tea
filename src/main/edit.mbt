///|
enum EditModel {
  Closed
  Editing(title~ : String, content~ : String, id~ : Int?)
}

///|
enum EditMsg {
  TitleChanged(String)
  ContentChanged(String)
  ReqResult(Result[Json, String])
  Close
} derive(Show)

///|
fn update_edit(
  msg : EditMsg,
  model : EditModel
) -> (@tea.Command[EditMsg], EditModel) {
  match (msg, model) {
    (TitleChanged(title), Editing(content~, id~, ..)) =>
      (@tea.none(), Editing(title~, content~, id~))
    (ContentChanged(content), Editing(title~, id~, ..)) =>
      (@tea.none(), Editing(title~, content~, id~))
    (Close, Editing(title="", content="", id=None)) => (@tea.none(), Closed)
    (Close, Editing(title="", content="", id=Some(id))) =>
      (
        @http.delete("/api/cards/\{id}", expect=Json(EditMsg::ReqResult)),
        Closed,
      )
    (Close, Editing(id~, title~, content~)) => {
      let cmd = match id {
        Some(id) =>
          @http.patch(
            "api/cards/\{id}",
            Json({
              "title": title.to_json(),
              "content": content.to_json(),
              "id": id.to_json(),
            }),
            expect=Json(EditMsg::ReqResult),
          )
        None =>
          @http.post(
            "/api/cards",
            Json({ "title": String(title), "content": String(content) }),
            expect=Json(EditMsg::ReqResult),
          )
      }
      (cmd, Closed)
    }
    (ReqResult(Ok(_)), _) => (@tea.none(), Closed)
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

///|
fn view_edit(model : EditModel) -> @html.Html[EditMsg] {
  match model {
    Closed => @html.div(style=["display: none"], [])
    Editing(title~, content~, id~) => {
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
          view_text_input("title", title, change=EditMsg::TitleChanged),
          view_text_input("content", content, change=EditMsg::ContentChanged),
          view_button("close", click=EditMsg::Close),
        ],
      )
    }
  }
}
