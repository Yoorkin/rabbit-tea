fn identity[A, B](a : A) -> B = "%identity"

type Any

extern "js" fn console_log(msg: String, any : Any) -> Unit =
  #| (msg,any) => console.log(msg,any)

struct Sandbox {
  mut model : Any
  update : (Any, Any) -> Any
  view : (Any) -> Any
  after_update : (Any) -> Unit
}

pub fn update[M](self : Sandbox, message : M) -> Unit {
  console_log("self model:",self.model)
  self.model = (self.update)(identity(message), self.model)
  console_log("updated model:",self.model)
  let view = (self.view)(self.model)
  console_log("updated view:",self.model)
  (self.after_update)(view)
  console_log("patched view:",self.model)
}

let global : Ref[Sandbox?] = @ref.new(None)

pub fn get_sandbox() -> Sandbox {
  global.val.unwrap()
}

pub fn init_sandbox[Model, Msg, View](
  model : Model,
  update : (Msg, Model) -> Model,
  view : (Model) -> View,
  ~after_update : (View) -> Unit
) -> Unit {
  global.val = Some(
    {
      model: identity(model),
      update: identity(update),
      view: identity(view),
      after_update: identity(after_update),
    },
  )
  after_update(view(model))
}

pub extern "js" fn listen(
  self : Element,
  event : String,
  callback : () -> Unit
) -> Unit =
  #| (self,event,callback) => self.addEventListener(event, callback)

type Element

pub extern "js" fn create_element(tag : String) -> Element =
  #| (tag) => { var d = document.createElement(tag); console.log(d); return d; }
  #|

pub extern "js" fn create_text_node(str : String) -> Element =
  #| (str) => document.createTextNode(str)

pub extern "js" fn set_attribute(
  self : Element,
  attr : String,
  value : String
) -> Unit =
  #| (self,attr,value) => {
  #|  console.log("set_attr",self);
  #|  self.setAttribute(attr, value);
  #| }

pub extern "js" fn append_child(self : Element, child : Element) -> Unit =
  #| (self,child) => self.appendChild(child)

pub extern "js" fn patch(element : Element) -> Unit =
  #| (element) => {
  #|   const app = document.getElementById("app");
  #|   while(app.firstChild) app.removeChild(app.firstChild);
  #|   app.appendChild(element);
  #| }
  #| 

// pub fn startup[Model, Message, View](
//   ~model : Model,
//   ~update : (Message, Model) -> Model,
//   ~view : (Model) -> View
// ) -> Unit {
//   global.val = Some(
//     { model: identity(model), update: identity(update), view: identity(view) },
//   )
// }

// enum Message {
//   Increment
// } derive(Show)

// fn update(message : Message, model : Model) -> Model {
//   println("message: \{message}, updating: \{model.x}")
//   { ..model, x: model.x + 1 }
// }

// fn view(model : Model) -> Html {
//   let view = "viewing: \{model.x}"
//   println(view)
//   view
// }

// pub fn initialize() -> Unit {
//   println("initialized")
//   listen("click", fn() { get_sandbox().update_view(identity(Increment)) })
//   startup(model={ x: 5 }, ~update, ~view)
// }
