///|
#external
type HTMLCanvasElement

///|
pub extern "js" fn HTMLCanvasElement::to_html_element(
  self : Self
) -> HTMLElement = "(x) => x"

///|
pub extern "js" fn HTMLCanvasElement::get_width(self : Self) -> Int = "(x) => x.width"

///|
pub extern "js" fn HTMLCanvasElement::get_height(self : Self) -> Int = "(x) => x.height"

///|
pub extern "js" fn HTMLCanvasElement::get_context(
  self : Self,
  context_id : String
) -> @js.Union5[
  CanvasRenderingContext2D,
  ImageBitmapRenderingContext,
  WebGLRenderingContext,
  WebGL2RenderingContext,
  GPUCanvasContext,
] = "(x, id) => x.getContext(id)"

// TODO: add CanvasText.measureText

// TODO: add TextMetrics
