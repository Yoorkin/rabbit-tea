///|
priv extern type WebSocket

///|
priv extern type CloseEvent

///|
extern "js" fn CloseEvent::get_code(self : CloseEvent) -> Int = "(self) => self.code"

///|
extern "js" fn CloseEvent::get_reason(self : CloseEvent) -> String = "(self) => self.reason"

///|
extern "js" fn CloseEvent::get_was_clean(self : CloseEvent) -> Bool = "(self) => self.wasClean"

///|
priv extern type MessageEvent

///|
extern "js" fn MessageEvent::get_data(self : MessageEvent) -> String = "(self) => self.data"

///|
extern "js" fn WebSocket::send(self : WebSocket, data : String) = "(self,data) => self.send(data)"

///|
extern "js" fn WebSocket::close(
  self : WebSocket,
  code~ : @js.Optional[Int] = @js.Optional::undefined(),
  reason~ : @js.Optional[String] = @js.Optional::undefined()
) = "(self,code,reason) => self.close(code,reason)"

///|
extern "js" fn WebSocket::new(
  url : String,
  on_open~ : (@dom.Event) -> Unit,
  on_message~ : (MessageEvent) -> Unit,
  on_error~ : (@dom.Event) -> Unit,
  on_close~ : (CloseEvent) -> Unit
) -> WebSocket =
  #| (url,onOpen,onMessage,onError,onClose) => {
  #|   const ws = new WebSocket(url);
  #|   ws.onopen = onOpen;
  #|   ws.onmessage = onMessage;
  #|   ws.onerror = onError;
  #|   ws.onclose = onClose;
  #|   return ws;
  #| }
