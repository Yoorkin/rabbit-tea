///|
#external
type CanvasPattern

///|
extern "js" fn checked_to_canvas_pattern(
  value : @js.Value
) -> @js.Nullable[CanvasPattern] =
  #| (value) => value instanceof CanvasPattern ? value : null

///|
pub impl @js.Cast for CanvasPattern with into(value) {
  checked_to_canvas_pattern(value).to_option()
}

///|
pub impl @js.Cast for CanvasPattern with from(value) {
  @js.Value::cast_from(value)
}

///|
pub extern "js" fn CanvasPattern::set_transform(
  self : Self,
  transform : @js.Optional[DOMMatrix2DInit]
) = "(self,transform) => self.setTransform(transform)"
