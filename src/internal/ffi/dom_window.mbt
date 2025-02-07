///|
type Window

///|
pub extern "js" fn scroll_to(self : Window, x : Int, y : Int) =
  #| (self, x, y) => { self.scrollTo(x, y); }

///|
pub extern "js" fn scroll_by(self : Window, x : Int, y : Int) =
  #| (self, x, y) => { self.scrollBy(x, y); }

///|
pub extern "js" fn scroll_to_top(self : Window) =
  #| (self) => { self.scrollTo(0, 0); }

///|
pub extern "js" fn scroll_to_bottom(self : Window) =
  #| (self) => { self.scrollTo(0, document.body.scrollHeight); }

///|
pub extern "js" fn history_go_back(self : Window) =
  #| (self) => { self.history.back(); }

///|
pub extern "js" fn history_go_forward(self : Window) =
  #| (self) => { self.history.forward(); }

///|
pub extern "js" fn load_url(self : Window, url : String) =
  #| (self,url) => { self.location.href = url; }

///|
pub extern "js" fn reload_url(self : Window) =
  #| (self) => { self.location.reload(); }

///|
pub extern "js" fn push_url(self : Window, url : String) =
  #| (self,url) => { self.history.pushState(null, '', url); }

///|
pub extern "js" fn current_url(self : Window) -> String =
  #| (self) => { return self.location.href; }

///|
pub extern "js" fn replace_url(self : Window, url : String) =
  #| (self,url) => { self.history.replaceState(null, '', url); }

///|
pub extern "js" fn request_animination_frame(self : Window, f : () -> Unit) = "(self,f) => { self.requestAnimationFrame(f); }"

///|
pub extern "js" fn window() -> Window = "() => window"

///|
pub extern "js" fn Window::to_event_target(self : Window) -> EventTarget = "(x) => x"
