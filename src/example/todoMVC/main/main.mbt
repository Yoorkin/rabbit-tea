///|
enum Message {
  GotHomeMsg(@home.Msg)
  GotEditorMsg(@editor.Msg)
  LinkClicked(@url.UrlRequest)
  UrlChanged(@url.Url)
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
    Home(model) => @home.view(model).map(GotHomeMsg(_))
    Editor(model) => @editor.view(model).map(GotEditorMsg(_))
    NotFound => @html.div([@html.text("Not Found")])
  }
}

///|
fn update_with[SubModel, SubMsg](
  pair : (@tea.Cmd[SubMsg], SubModel),
  to_model : (SubModel) -> Model,
  to_msg : (SubMsg) -> Message
) -> (@tea.Cmd[Message], Model) {
  let (cmd, model) = pair
  (cmd.map(to_msg), to_model(model))
}

///|
fn update(msg : Message, model : Model) -> (@tea.Cmd[Message], Model) {
  match (msg, model) {
    (GotHomeMsg(msg), Home(model)) =>
      @home.update(msg, model) |> update_with(Home(_), GotHomeMsg(_))
    (GotEditorMsg(msg), Editor(model)) =>
      @editor.update(msg, model) |> update_with(Editor(_), GotEditorMsg(_))
    (LinkClicked(request), _) =>
      match request {
        Internal(url) => (@nav.push_url(url.to_string()), model)
        External(url) => (@nav.load(url), model)
      }
    (UrlChanged(url), _) => route(url)
    _ => (@tea.none(), model)
  }
}

///|
fn route(url : @url.Url) -> (@tea.Cmd[Message], Model) {
  let paths = url.path.split("/").collect()
  println("routing to \{url.to_string()}, path \{paths}")
  match paths {
    ["home" | "/" | ""] => @home.load() |> update_with(Home(_), GotHomeMsg(_))
    ["new"] => @editor.load(None) |> update_with(Editor(_), GotEditorMsg(_))
    ["cards", id] =>
      match @strconv.parse_int?(id.to_string()) {
        Ok(id) =>
          @editor.load(Some(id)) |> update_with(Editor(_), GotEditorMsg(_))
        Err(err) => {
          println("error parsing id \{err}")
          (@tea.none(), NotFound)
        }
      }
    _ => (@cmd.none(), NotFound)
  }
}

///|
fn main {
  @tea.application(
    initialize=route,
    update~,
    view~,
    url_request=LinkClicked(_),
    url_changed=UrlChanged(_),
  )
}
