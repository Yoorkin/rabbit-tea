///|
pub extern "js" fn scroll_to(x : Int, y : Int) =
  #| (x, y) => { window.scrollTo(x, y); }

///|
pub extern "js" fn scroll_by(x : Int, y : Int) =
  #| (x, y) => { window.scrollBy(x, y); }

///|
pub extern "js" fn scroll_to_top() =
  #| () => { window.scrollTo(0, 0); }

///|
pub extern "js" fn scroll_to_bottom() =
  #| () => { window.scrollTo(0, document.body.scrollHeight); }

///|
pub extern "js" fn history_go_back() =
  #| () => { window.history.back(); }

///|
pub extern "js" fn history_go_forward() =
  #| () => { window.history.forward(); }

///|
pub extern "js" fn load_url(url : String) =
  #| (url) => { window.location.href = url; }

///|
pub extern "js" fn reload_url() =
  #| () => { window.location.reload(); }

///|
pub extern "js" fn push_url(url : String) =
  #| (url) => { window.history.pushState(null, '', url); }

///|
pub extern "js" fn current_url() -> String =
  #| () => { return window.location.href; }

///|
pub extern "js" fn replace_url(url : String) =
  #| (url) => { window.history.replaceState(null, '', url); }

///|
pub extern "js" fn request_animination_frame(f : () -> Unit) = "(f) => { window.requestAnimationFrame(f); }"
