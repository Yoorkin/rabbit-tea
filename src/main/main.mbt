enum Message {
  EditCard(Int)
  DeleteAll
  RefreshList
  NewCard
  ReqResult(Result[Json, String])
  GotEditMsg(EditMsg)
  GotCardsData(Result[Json, String])
} derive(Show)

enum Model {
  Home(Array[CardModel])
  Edit(EditModel)
}

extern "js" fn console_log(msg : String) =
  #| (msg) => console.log(msg)

fn update_with[SubModel, Model, SubMsg, Msg](
  data : (@tea.Command[SubMsg], SubModel),
  map_model : (SubModel) -> Model,
  map_msg : (SubMsg) -> Msg
) -> (@tea.Command[Msg], Model) {
  let (cmd, sub_model) = data
  (cmd.map(map_msg), map_model(sub_model))
}

fn update(msg : Message, model : Model) -> (@tea.Command[Message], Model) {
  match (msg, model) {
    (NewCard, _) => (@tea.none(), Edit(Editing(title="", content="", id=None)))
    (GotEditMsg(msg), Edit(model)) => {
      let (cmds, model) as result = update_edit(msg, model)
      match model {
        Closed =>
          (
            @tea.batch([cmds.map(Message::GotEditMsg), @tea.task(RefreshList)]),
            Home([]),
          )
        _ => result |> update_with(Model::Edit, Message::GotEditMsg)
      }
    }
    (EditCard(id), Home(cards)) => {
      let edit = match cards.filter(fn(card) { card.id() == id }) {
        [Card(content, ~id)] => Editing(title="", ~content, id=Some(id))
        [TitleCard(~title, ~content, ~id)] =>
          Editing(~title, ~content, id=Some(id))
      }
      (@tea.none(), Edit(edit))
    }
    (DeleteAll, Home(cards)) => {
      let cmds = @tea.batch(
        cards.map(
          fn(card) {
            @http.delete(
              "/api/cards/\{card.id()}",
              expect=Json(Message::ReqResult),
            )
          },
        ),
      )
      (cmds, Home([]))
    }
    (RefreshList, _) =>
      (@http.get("/api/cards", expect=Json(Message::GotCardsData)), model)
    (GotCardsData(Ok(json)), Home(cards)) => {
      let cards = match json {
        { "cards": Array(elems) } =>
          elems.map_option(
            fn {
              {
                "title"? : Some(String("")) | None,
                "content": String(content),
                "id": Number(id),
              } => Some(Card(content, id=id.to_int()))
              {
                "title": String(title),
                "content": String(content),
                "id": Number(id),
              } => Some(TitleCard(~title, ~content, id=id.to_int()))
              _ => None
            },
          )
      }
      (@tea.none(), Home(cards))
    }
    (ReqResult(Ok(_)), _) => (@tea.none(), model)
    (msg, _) => {
      console_log("unhandled message \{msg}")
      (@tea.none(), model)
    }
  }
}

let button_style = [
  "background: pink", "border-radius: 10px", "width:80px", "padding:20px", "margin:10px",
]

fn view_button[M](text : String, ~click : M) -> @html.Html[M] {
  @html.div(style=button_style, [@html.text(text)], ~click)
}

fn view(model : Model) -> @html.Html[Message] {
  match model {
    Home(model) =>
      @html.div(
        style=["display:flex", "flex-direction:column"],
        [
          @html.h1([@html.text("MoonBit TodoMVC")]),
          @html.div(
            style=["display: flex", "width: 500px", "height: 100%"],
            [
              view_button("clear", click=DeleteAll),
              view_button("refersh", click=RefreshList),
              view_button("+", click=NewCard),
            ],
          ),
          @html.p(
            [@html.text("Click cards below to edit, click + to add a new card")],
          ),
          view_list(model),
        ],
      )
    Edit(model) => view_edit(model).map(Message::GotEditMsg)
  }
}

fn main {
  let model = Home([Card("click refersh to request data from server", id=0)])
  @tea.startup(~model, ~update, ~view)
}
