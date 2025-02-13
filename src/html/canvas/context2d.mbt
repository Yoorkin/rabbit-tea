///|
type Context2D @ffi.CanvasRenderingContext2D

///|
pub fn begin_path(self : Context2D) -> Unit {
  self._.begin_path()
}

///|
pub fn move_to(self : Context2D, x : Double, y : Double) -> Unit {
  self._.move_to(x, y)
}

///|
pub fn line_to(self : Context2D, x : Double, y : Double) -> Unit {
  self._.line_to(x, y)
}

///|
pub fn set_line_width(self : Context2D, width : Double) -> Unit {
  self._.set_line_width(width)
}

///|
pub fn stroke(self : Context2D) -> Unit {
  self._.stroke()
}

///|
pub fn fill_rect(
  self : Context2D,
  x : Double,
  y : Double,
  width : Double,
  height : Double
) -> Unit {
  self._.fill_rect(x, y, width, height)
}
