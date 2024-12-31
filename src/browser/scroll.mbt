///|
extern "js" fn ffi_scroll_to(x : Int, y : Int) =
  #| (x, y) => { window.scrollTo(x, y); }

///|
extern "js" fn ffi_scroll_by(x : Int, y : Int) =
  #| (x, y) => { window.scrollBy(x, y); }

///|
extern "js" fn ffi_scroll_to_element(element : String) =
  #| (element) => { document.getElementById(element).scrollIntoView(); }

///|
extern "js" fn ffi_scroll_to_top() =
  #| () => { window.scrollTo(0, 0); }

///|
extern "js" fn ffi_scroll_to_bottom() =
  #| () => { window.scrollTo(0, document.body.scrollHeight); }

///|
pub fn scroll_to_pos[M](x : Int, y : Int) -> Command[M] {
  fn(_events, update) { ffi_scroll_to(x, y) }
}

///|
pub fn scroll_by_pos[M](x : Int, y : Int) -> Command[M] {
  fn(_events, update) { ffi_scroll_by(x, y) }
}

///|
pub fn scroll_to[M](element : String) -> Command[M] {
  fn(_events, update) { ffi_scroll_to_element(element) }
}

///|
pub fn scroll_to_top[M]() -> Command[M] {
  fn(_events, update) { ffi_scroll_to_top() }
}

///|
pub fn scroll_to_bottom[M]() -> Command[M] {
  fn(_events, update) { ffi_scroll_to_bottom() }
}
