enum Message {
  DeleteAll
  Refresh
  GotCards(Result[Json, String])
  NewCard
  EditCard(Int)
  CloseEdit
  OpResult(Result[Json, String])
} derive(Show)

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

enum Model {
  Edit(~title : String, ~content : String, ~id : Int?)
  Home(~cards : Array[CardModel])
}

extern "js" fn console_log(msg : String) =
  #| (msg) => console.log(msg)

fn update(msg : Message, model : Model) -> (@tea.Command[Message], Model) {
  match model {
    Edit(~title, ~content, ~id) => match msg {
      CloseEdit => {
        let json = {
          "title": title,
          "content": content
        }
        match id {
          Some(id) => (@http, Home(~cards))
        }
      }
      msg => {
        console_log("unhandled message \{msg}")
        panic()
      }
    }
    Home(~cards) =>
      match msg {
        DeleteAll => {
          let cmds = @tea.batch(
            cards.map(
              fn(card) {
                @http.delete(
                  "/api/cards/\{card.id()}",
                  expect=Json(Message::OpResult),
                )
              },
            ),
          )
          (cmds, Home(cards=[]))
        }
        Refresh =>
          (@http.get("/api/cards", expect=Json(Message::GotCards)), model)
        GotCards(Ok(json)) => {
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
          
          (@tea.none(), Home(~cards))
        }
        GotCards(Err(str)) => {
          console_log("failed: \{str}")
          (@tea.none(), model)
        }
        NewCard => (@tea.none(), Edit(title="", content="", id=None))
        EditCard(id) => {
          let model = match cards.filter(fn(card) { card.id() == id }) {
            [Card(content, ~id)] => Edit(title="", ~content, id=Some(id))
            [TitleCard(~title, ~content, ~id)] =>
              Edit(~title, ~content, id=Some(id))
          }
          (@tea.none(), model)
        }
        msg => {
          console_log("unhandled message \{msg}")
          panic()
        }
      }
  }
}

let button_style = [
  "background: pink", "border-radius: 10px", "width:80px", "padding:20px", "margin:10px",
]

fn card_view(card : CardModel) -> @html.Html[Message] {
  let (elements, id) = match card {
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

fn home_view(cards : Array[CardModel]) -> @html.Html[Message] {
  @html.div(
    style=["display:flex", "flex-direction:column"],
    [
      @html.h1([@html.text("MoonBit TodoMVC")]),
      @html.div(
        style=["display: flex", "width: 500px", "height: 100%"],
        [
          @html.div(style=button_style, [@html.text("clear")], click=DeleteAll),
          @html.div(style=button_style, [@html.text("refresh")], click=Refresh),
          @html.div(style=button_style, [@html.text("+")], click=NewCard),
        ],
      ),
      @html.div(
        style=[
          "display: flex", "flex-direction: column", "width: 500px", "height: 100%",
        ],
        cards.map(card_view),
      ),
    ],
  )
}

fn editor_view(
  ~title : String,
  ~content : String,
  ~id : Int?
) -> @html.Html[Message] {
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
      @html.label(for_="title", [@html.text("Title")]),
      @html.input(
        style=["border: 1px solid #ccc", "border-radius: 5px", "padding: 5px"],
        id="title",
        value=title,
        input_type=Text,
      ),
      @html.label(for_="content", [@html.text("content")]),
      @html.input(
        style=["border: 1px solid #ccc", "border-radius: 5px", "padding: 5px"],
        id="content",
        value=content,
        input_type=Text,
      ),
      @html.div(style=button_style, [@html.text("close")], click=CloseEdit),
    ],
  )
}

fn view(model : Model) -> @html.Html[Message] {
  match model {
    Home(~cards) => home_view(cards)
    Edit(~title, ~content, ~id) => editor_view(~title, ~content, ~id)
  }
}

fn main {
  let model = Home(
    cards=[Card("click refersh to request data from server", id=0)],
  )
  @tea.startup(~model, ~update, ~view)
}
