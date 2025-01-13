///|
enum Message {
  GotHomeMsg(@home.Msg)
  GotEditorMsg(@editor.Msg)
  UrlRequest(@browser.UrlRequest)
} derive(Show)

///|
enum Model {
  NotFound
  Home(@home.Model)
  Editor(@editor.Model)
}

///|
fn view(model : Model) -> @html.Html[Message] {
  match model {
    Home(model) => @home.view(model).map(Message::GotHomeMsg)
    Editor(model) => @editor.view(model).map(Message::GotEditorMsg)
    NotFound => @html.div([@html.text("Not Found")])
  }
}

///|
fn update_with[SubModel, SubMsg](
  pair : (@tea.Command[SubMsg], SubModel),
  to_model : (SubModel) -> Model,
  to_msg : (SubMsg) -> Message
) -> (@tea.Command[Message], Model) {
  let (cmd, model) = pair
  (cmd.map(to_msg), to_model(model))
}

///|
fn update(msg : Message, model : Model) -> (@tea.Command[Message], Model) {
  match (msg, model) {
    (GotHomeMsg(msg), Home(model)) =>
      @home.update(msg, model) |> update_with(Model::Home, Message::GotHomeMsg)
    (GotEditorMsg(msg), Editor(model)) =>
      @editor.update(msg, model)
      |> update_with(Model::Editor, Message::GotEditorMsg)
    (UrlRequest(Internal(url)), _) => {
      let (cmd, model) = route(url)
      (@browser.batch([cmd, @browser.push_url(url.to_string())]), model)
    }
    (UrlRequest(External(url)), _) => (@browser.load(url), model)
    _ => (@tea.none(), NotFound)
  }
}

///|
fn route(url : @url.Url) -> (@tea.Command[Message], Model) {
  println("routing to \{url.path}")
  let paths = url.path.split("/").collect()
  match paths {
    ["home"] | [] =>
      @home.load() |> update_with(Model::Home, Message::GotHomeMsg)
    ["new"] =>
      @editor.load(None) |> update_with(Model::Editor, Message::GotEditorMsg)
    ["cards", id] => {
      guard let Ok(id) = @strconv.parse_int?(id) else {
        _ => (@tea.none(), NotFound)
      }
      @editor.load(Some(id))
      |> update_with(Model::Editor, Message::GotEditorMsg)
    }
    _ => (@tea.none(), NotFound)
  }
}

///|
fn main {
  @tea.application(
    initialize=route,
    update~,
    view~,
    url_request=Message::UrlRequest,
  )
}
