///|
pub(all) enum Respone {
  Open(Socket)
  Message(Socket, data~ : String)
  Error(Socket)
  Close(Socket, code~ : Int, reason~ : String, was_clean~ : Bool)
}

///|
type Socket WebSocket

///|
typealias @cmd.Cmd[M]

///|
pub fn send[M](self : Socket, data : String) -> Cmd[M] {
  @cmd.Cmd(fn(_) { self._.send(data) })
}

///|
pub fn close[M](self : Socket, code? : Int, reason? : String) -> Cmd[M] {
  @cmd.Cmd(fn(_) {
    self._.close(
      code=@js.Optional::from_option(code),
      reason=@js.Optional::from_option(reason),
    )
  })
}

///|
pub fn new[M](url : String, to_msg : (Respone) -> M) -> Cmd[M] {
  @cmd.Cmd(fn(tea) {
    let mut self : Socket? = None
    let ws = WebSocket::new(
      url,
      on_close=fn(event) {
        tea.trigger_update(
          to_msg(
            Close(
              self.unwrap(),
              code=event.get_code(),
              reason=event.get_reason(),
              was_clean=event.get_was_clean(),
            ),
          ),
        )
      },
      on_open=fn(_) { tea.trigger_update(to_msg(Open(self.unwrap()))) },
      on_message=fn(event) {
        tea.trigger_update(
          to_msg(Message(self.unwrap(), data=event.get_data())),
        )
      },
      on_error=fn(_) { tea.trigger_update(to_msg(Error(self.unwrap()))) },
    )
    self = Some(ws)
  })
}
