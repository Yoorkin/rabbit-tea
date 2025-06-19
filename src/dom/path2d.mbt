///|
#external
type Path2D

///|
pub extern "js" fn Path2D::new(
  path~ : @js.Optional[@js.Union2[Path2D, String]] = @js.Optional::undefined()
) -> Path2D = "(path) => new Path2D(path)"

///|
pub extern "js" fn Path2D::add_path(
  self : Path2D,
  path : Path2D,
  transform~ : @js.Optional[DOMMatrix2DInit] = @js.Optional::undefined()
) = "(self,path,transform) => self.addPath(path,transform)"
