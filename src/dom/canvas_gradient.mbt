///|
#external
type CanvasGradient

///|
pub extern "js" fn CanvasGradient::add_color_stop(
  self : CanvasGradient,
  offset : Double,
  color : String
) = "(self,offset,color) => self.addColorStop(offset,color)"

///|
extern "js" fn checked_to_canvas_gradient(
  value : @js.Value
) -> @js.Nullable[CanvasGradient] =
  #| (value) => value instanceof CanvasGradient ? value : null

///|
pub impl @js.Cast for CanvasGradient with into(value) {
  checked_to_canvas_gradient(value).to_option()
}

///|
pub impl @js.Cast for CanvasGradient with from(value) {
  @js.Value::cast_from(value)
}
