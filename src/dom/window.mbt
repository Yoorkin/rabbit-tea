///|
#external
type Window

///|
pub extern "js" fn Window::scroll_to(self : Self, x : Int, y : Int) =
  #| (self, x, y) => { self.scrollTo(x, y); }

///|
pub extern "js" fn Window::scroll_by(self : Self, x : Int, y : Int) =
  #| (self, x, y) => { self.scrollBy(x, y); }

///|
pub extern "js" fn Window::scroll_to_top(self : Self) =
  #| (self) => { self.scrollTo(0, 0); }

///|
pub extern "js" fn Window::scroll_to_bottom(self : Self) =
  #| (self) => { self.scrollTo(0, document.body.scrollHeight); }

///|
pub extern "js" fn Window::history_go_back(self : Self) =
  #| (self) => { self.history.back(); }

///|
pub extern "js" fn Window::history_go_forward(self : Self) =
  #| (self) => { self.history.forward(); }

///|
pub extern "js" fn Window::load_url(self : Self, url : String) =
  #| (self,url) => { self.location.href = url; }

///|
pub extern "js" fn Window::reload_url(self : Self) =
  #| (self) => { self.location.reload(); }

///|
pub extern "js" fn Window::push_url(self : Self, url : String) =
  #| (self,url) => { self.history.pushState(null, '', url); }

///|
pub extern "js" fn Window::current_url(self : Self) -> String =
  #| (self) => { return self.location.href; }

///|
pub extern "js" fn Window::replace_url(self : Self, url : String) =
  #| (self,url) => { self.history.replaceState(null, '', url); }

///| https://developer.mozilla.org/en-US/docs/Web/API/Window/requestAnimationFrame
pub extern "js" fn Window::request_animation_frame(
  self : Self,
  f : (DOMHighResTimeStamp) -> Unit
) -> Double = "(self,f) => self.requestAnimationFrame(f)"

///| https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame
pub extern "js" fn Window::cancel_animation_frame(
  self : Self,
  request_id : Double
) = "(self,id) => self.cancelAnimationFrame(id)"

///|
pub extern "js" fn window() -> Window = "() => window"

///|
pub extern "js" fn Window::to_event_target(self : Self) -> EventTarget = "(x) => x"

///|
pub extern "js" fn Window::alert(self : Self, msg : String) = "(self,msg) => self.alert(msg)"

///|
pub extern "js" fn Window::confirm(self : Self, msg : String) -> Bool = "(self,msg) => self.confirm(msg)"

///|
pub extern "js" fn Window::navigator(self : Self) -> Navigator =
  #| (self) => self.navigator
