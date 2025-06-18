///|
type Context2D @dom.CanvasRenderingContext2D

///| Get the underlying `CanvasRenderingContext2D` js object.
/// 
/// This function is unsafe and should be used rarely.
pub fn to_unsafe_js(self : Context2D) -> @dom.CanvasRenderingContext2D {
  self.inner()
}

///|
pub fn begin_path(self : Context2D) -> Unit {
  self.inner().begin_path()
}

///|
pub fn move_to(self : Context2D, x : Double, y : Double) -> Unit {
  self.inner().move_to(x, y)
}

///|
pub fn line_to(self : Context2D, x : Double, y : Double) -> Unit {
  self.inner().line_to(x, y)
}

///|
pub fn set_line_width(self : Context2D, width : Double) -> Unit {
  self.inner().set_line_width(width)
}

///|
pub fn stroke(self : Context2D) -> Unit {
  self.inner().stroke()
}

///|
pub(all) enum Color {
  RGB(Int, Int, Int)
  RGBA(Int, Int, Int, Int)
  Black
  White
} derive(Show)

///|
pub fn to_string(self : Color) -> String {
  match self {
    RGB(r, g, b) => "rgb(\{r}, \{g}, \{b})"
    RGBA(r, g, b, a) => "rgba(\{r}, \{g}, \{b}, \{a})"
    Black => "black"
    White => "white"
  }
}

///|
pub fn set_stroke_style(self : Context2D, color : Color) -> Unit {
  self.inner().set_stroke_style(@js.Union3::from0(color.to_string()))
}

///|
pub fn set_fill_style(self : Context2D, color : Color) -> Unit {
  self.inner().set_fill_style(@js.Union3::from0(color.to_string()))
}

///|
pub fn fill_rect(
  self : Context2D,
  x : Double,
  y : Double,
  width : Double,
  height : Double
) -> Unit {
  self.inner().fill_rect(x, y, width, height)
}

///|
pub fn clear_rect(
  self : Context2D,
  x : Double,
  y : Double,
  width : Double,
  height : Double
) -> Unit {
  self.inner().clear_rect(x, y, width, height)
}

///|
pub fn fill_text(
  self : Context2D,
  text : String,
  x : Double,
  y : Double
) -> Unit {
  self.inner().fill_text(text, x, y)
}
