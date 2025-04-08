///|
pub extern type DevTool

///|
extern "js" fn ffi_send(self : DevTool, action : @js.Value, state : @js.Value) =
  #| (self,action,state) => self.send(action.toString(), state)

///|
extern "js" fn ffi_subscribe(self : DevTool, f : (@js.Value) -> Unit) =
  #| (self, f) => self.subscribe(f)

///|
extern "js" fn ffi_connect() -> DevTool =
  #| () => window.__REDUX_DEVTOOLS_EXTENSION__.connect({ name: "Rabbit-TEA"})

///|
pub fn connect() -> DevTool {
  println("connect")
  ffi_connect()
}
///|
fn any_to_string[T](any : T) -> String = "%any.to_string"

///|
pub fn send[Msg, Model](self : DevTool, action : Msg, state : Model) -> Unit {
  println("send:")
  println(@js.Value::cast_from(action))
  println(@js.Value::cast_from(state))
  let action = @js.Value::cast_from(any_to_string(action))
  let state = @js.Value::cast_from(state)
  ffi_send(self, action, state)
}

extern "js" fn debug_value(value : @js.Value) = #| (value) => console.log(JSON.stringify(value))
extern "js" fn json_parse(value : @js.Value) -> @js.Value = #| (value) => JSON.parse(value.state)

///|
pub fn subscribe[Model](self : DevTool, f : (Model) -> Unit) -> Unit {
  ffi_subscribe(self, fn(value) { 
    println("subscribe:")
    debug_value(value)
    debug_value(json_parse(value))
    json_parse(value).cast() |> f })
}
