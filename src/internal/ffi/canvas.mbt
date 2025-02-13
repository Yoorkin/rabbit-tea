///|
type HTMLCanvasElement

///|
pub extern "js" fn HTMLCanvasElement::to_html_element(
  self : HTMLCanvasElement
) -> HTMLElement = "(x) => x"

///|
pub extern "js" fn HTMLCanvasElement::get_width(
  self : HTMLCanvasElement
) -> Int = "(x) => x.width"

///|
pub extern "js" fn HTMLCanvasElement::get_height(
  self : HTMLCanvasElement
) -> Int = "(x) => x.height"

///|
pub extern "js" fn HTMLCanvasElement::get_context(
  self : HTMLCanvasElement,
  context_id : String
) ->
     @js.Union5[
       CanvasRenderingContext2D,
       ImageBitmapRenderingContext,
       WebGLRenderingContext,
       WebGL2RenderingContext,
       GPUCanvasContext,
     ] = "(x, id) => x.getContext(id)"

///|
type CanvasRenderingContext2D

///|
extern "js" fn checked_to_canvas_rendering_context_2d(
  value : @js.Value
) -> @js.Nullable[CanvasRenderingContext2D] =
  #| (value) => value instanceof CanvasRenderingContext2D ? value : null

///|
pub impl @js.Cast for CanvasRenderingContext2D with into(value) {
  checked_to_canvas_rendering_context_2d(value).to_option()
}

///|
pub impl @js.Cast for CanvasRenderingContext2D with from(value) {
  @js.Value::cast_from(value)
}

///|
type ImageBitmapRenderingContext

///|
type WebGLRenderingContext

///|
type WebGL2RenderingContext

///|
type GPUCanvasContext

///|
pub extern "js" fn CanvasRenderingContext2D::save(
  self : CanvasRenderingContext2D
) = "(x) => x.save()"

///|
pub extern "js" fn CanvasRenderingContext2D::restore(
  self : CanvasRenderingContext2D
) = "(x) => x.restore()"

///|
pub extern "js" fn CanvasRenderingContext2D::reset(
  self : CanvasRenderingContext2D
) = "(x) => x.reset()"

///|
pub extern "js" fn CanvasRenderingContext2D::is_context_lost(
  self : CanvasRenderingContext2D
) -> Bool = "() => x.isContextLost()"

///|
pub extern "js" fn CanvasRenderingContext2D::scale(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double
) = "(x,y) => x.scale(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::rotate(
  self : CanvasRenderingContext2D,
  angle : Double
) = "(x,angle) => x.rotate(angle)"

///|
pub extern "js" fn CanvasRenderingContext2D::translate(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double
) = "(x,y) => x.translate(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::transform(
  self : CanvasRenderingContext2D,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) = "(x,a,b,c,d,e,f) => x.transform(a,b,c,d,e,f)"

///|
pub extern "js" fn CanvasRenderingContext2D::set_transform(
  self : CanvasRenderingContext2D,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) = "(x,a,b,c,d,e,f) => x.setTransform(a,b,c,d,e,f)"

///|
pub extern "js" fn CanvasRenderingContext2D::reset_transform(
  self : CanvasRenderingContext2D
) = "(x) => x.resetTransform()"

// TODO: add interface CanvasCompositing
///|
pub extern "js" fn CanvasRenderingContext2D::image_smoothing_enabled(
  self : CanvasRenderingContext2D
) -> Bool = "(x) => x.imageSmoothingEnabled"

///|
pub extern "js" fn CanvasRenderingContext2D::get_image_smoothing_quality(
  self : CanvasRenderingContext2D
) -> String = "(x) => x.imageSmoothingQuality"

///| Possible values are "low", "medium", and "high".
pub extern "js" fn CanvasRenderingContext2D::set_image_smoothing_quality(
  self : CanvasRenderingContext2D,
  value : String
) = "(x,value) => x.imageSmoothingQuality = value"

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
pub extern "js" fn CanvasRenderingContext2D::get_stroke_style(
  self : CanvasRenderingContext2D
) -> @js.Union3[String, CanvasGradient, CanvasPattern] =
  #| (x) => x.strokeStyle

///|
pub extern "js" fn CanvasRenderingContext2D::set_stroke_style(
  self : CanvasRenderingContext2D,
  value : @js.Union3[String, CanvasGradient, CanvasPattern]
) =
  #| (x,value) => x.strokeStyle = value

///|
pub extern "js" fn CanvasRenderingContext2D::create_linear_gradient(
  self : CanvasRenderingContext2D,
  x0 : Double,
  y0 : Double,
  x1 : Double,
  y1 : Double
) -> CanvasGradient = "(x,x0,y0,x1,y1) => x.createLinearGradient(x0,y0,x1,y1)"

///|
pub extern "js" fn CanvasRenderingContext2D::create_radial_gradient(
  self : CanvasRenderingContext2D,
  x0 : Double,
  y0 : Double,
  r0 : Double,
  x1 : Double,
  y1 : Double,
  r1 : Double
) -> CanvasGradient = "(x,x0,y0,r0,x1,y1,r1) => x.createRadialGradient(x0,y0,r0,x1,y1,r1)"

// TODO: add interface CanvasShadowStyles
// TODO: add interface CanvasFilters

///|
pub extern "js" fn CanvasRenderingContext2D::clear_rect(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.clearRect(x,y,w,h)"

///|
pub extern "js" fn CanvasRenderingContext2D::fill_rect(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.fillRect(x,y,w,h)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_rect(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.stroke_rect(x,y,w,h)"

// TODO: add interface CanvasDrawPath

///|
pub extern "js" fn CanvasRenderingContext2D::begin_path(
  self : CanvasRenderingContext2D
) = "(self) => self.beginPath()"

///|
pub extern "js" fn CanvasRenderingContext2D::fill(
  self : CanvasRenderingContext2D,
  fill_rule~ : String = "nonzero"
) = "(self, fillRule) => self.fill(fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::fill_path(
  self : CanvasRenderingContext2D,
  path : Path2D,
  fill_rule~ : String = "nonzero"
) = "(self,path,fillRule) => self.stroke(path,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke(
  self : CanvasRenderingContext2D
) = "(self) => self.stroke()"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_with_path(
  self : CanvasRenderingContext2D,
  path : Path2D
) = "(self,path) => self.stroke(path)"

///|
pub extern "js" fn CanvasRenderingContext2D::clip(
  self : CanvasRenderingContext2D,
  fill_rule~ : String = "nonzero"
) = "(self, fillRule) => self.clip(fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::clip_with_path(
  self : CanvasRenderingContext2D,
  path : Path2D,
  fill_rule~ : String = "nonzero"
) = "(self,path,fillRule) => self.clip(path,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_path(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  fill_rule~ : String = "nonzero"
) -> Bool = "(self,x,y,fillRule) => self.isPointInPath(x,y,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_path_with_path(
  self : CanvasRenderingContext2D,
  path : Path2D,
  x : Double,
  y : Double,
  fill_rule~ : String = "nonzero"
) -> Bool = "(self,path,x,y,fillRule) => self.isPointInPath(path,x,y,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_stroke(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double
) -> Bool = "(self,x,y) => self.isPointInStroke(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_stroke_with_path(
  self : CanvasRenderingContext2D,
  path : Path2D,
  x : Double,
  y : Double
) -> Bool = "(self,path,x,y) => self.isPointInStroke(path,x,y)"

// TODO: add interface CanvasUserInterface

///|
pub extern "js" fn CanvasRenderingContext2D::fill_text(
  self : CanvasRenderingContext2D,
  text : String,
  x : Double,
  y : Double,
  max_width~ : @js.Optional[Double] = @js.Optional::undefined()
) = "(self,text,x,y,maxWidth) => self.fill_text(text,x,y,maxWidth)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_text(
  self : CanvasRenderingContext2D,
  text : String,
  x : Double,
  y : Double,
  max_width~ : @js.Optional[Double] = @js.Optional::undefined()
) = "(self,text,x,y,maxWidth) => self.stroke_text(text,x,y,maxWidth)"

// TODO: add ConvasText.measureText

///|
pub extern "js" fn CanvasRenderingContext2D::draw_image(
  self : CanvasRenderingContext2D,
  dx : Double,
  dy : Double
) = "(self,image,dx,dy) => self.drawImage(image,dx,dy)"

///|
pub extern "js" fn CanvasRenderingContext2D::draw_image_with_size(
  self : CanvasRenderingContext2D,
  dx : Double,
  dy : Double,
  dw : Double,
  dh : Double
) = "(self,image,dx,dy,dw,dh) => self.drawImage(image,dx,dy,dw,dh)"

///|
pub extern "js" fn CanvasRenderingContext2D::draw_image_with_src_and_dst_size(
  self : CanvasRenderingContext2D,
  sx : Double,
  sy : Double,
  sw : Double,
  sh : Double,
  dx : Double,
  dy : Double,
  dw : Double,
  dh : Double
) = "(self,image,sx,sy,sw,sh,dx,dy,dw,dh) => self.drawImage(image,sx,sy,sw,sh,dx,dy,dw,dh)"

///|
pub extern "js" fn CanvasRenderingContext2D::create_image_data(
  self : CanvasRenderingContext2D,
  sw : Double,
  sh : Double,
  settings~ : @js.Optional[ImageDataSettings] = @js.Optional::undefined()
) -> ImageData = "(self,sw,sh,settings) => self.createImageData(sw,sh,settings)"

///|
pub extern "js" fn CanvasRenderingContext2D::create_image_data_with_data(
  self : CanvasRenderingContext2D,
  data : ImageData
) -> ImageData = "(self,data) => self.createImageData(data)"

///|
pub extern "js" fn CanvasRenderingContext2D::get_image_data(
  self : CanvasRenderingContext2D,
  sx : Double,
  sy : Double,
  sw : Double,
  sh : Double,
  settings~ : @js.Optional[ImageDataSettings] = @js.Optional::undefined()
) -> ImageData = "(self,sx,sy,sw,sh) => self.getImageData(sx,sy,sw,sh)"

///|
pub extern "js" fn CanvasRenderingContext2D::put_image_data(
  self : CanvasRenderingContext2D,
  image_data : ImageData,
  dx : Int,
  dy : Int
) = "(self,imageData,dx,dy) => self.putImageData(imageData,dx,dy)"

///|
pub extern "js" fn CanvasRenderingContext2D::put_image_data_with_dirty(
  self : CanvasRenderingContext2D,
  image_data : ImageData,
  dx : Int,
  dy : Int,
  dirty_x : Int,
  dirty_y : Int,
  dirty_width : Int,
  dirty_height : Int
) =
  #| (self,imageData,dx,dy,dirtyX,dirtyY,dirtyWidth,dirtyHeight) => 
  #|    self.putImageData(imageData,dx,dy,dirtyX,dirtyY,dirtyWidth,dirtyHeight)

///|
pub extern "js" fn CanvasRenderingContext2D::get_line_with(
  self : CanvasRenderingContext2D
) -> Double = "(self) => self.lineWidth"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_width(
  self : CanvasRenderingContext2D,
  value : Double
) = "(self,value) => self.lineWidth = value"

///|
type CanvasLineCap

///|
type CanvasLineJoin

///|
pub extern "js" fn CanvasRenderingContext2D::get_line_cap(
  self : CanvasRenderingContext2D
) -> CanvasLineCap = "(self) => self.lineCap"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_cap(
  self : CanvasRenderingContext2D,
  value : CanvasLineCap
) = "(self,value) => self.lineCap = value"

///|
pub extern "js" fn CanvasRenderingContext2D::get_line_join(
  self : CanvasRenderingContext2D
) -> CanvasLineJoin = "(self) => self.lineJoin"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_join(
  self : CanvasRenderingContext2D,
  value : CanvasLineJoin
) = "(self,value) => self.lineJoin = value"

// TODO: add CanvasPathDrawingStyles.setLineDash, CanvasPathDrawingStyles.getLineDash, CanvasPathDrawingStyles.getLineDashOffset
// TODO: add CanvasTextDrawingStyles

///|
pub extern "js" fn CanvasRenderingContext2D::close_path(
  self : CanvasRenderingContext2D
) = "(self) => self.closePath()"

///|
pub extern "js" fn CanvasRenderingContext2D::move_to(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double
) = "(self,x,y) => self.moveTo(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::line_to(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double
) = "(self,x,y) => self.lineTo(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::quardratic_curve_to(
  self : CanvasRenderingContext2D,
  cpx : Double,
  cpy : Double,
  x : Double,
  y : Double
) = "(self,cpx,cpy,x,y) => self.quadraticCurveTo(cpx,cpy,x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::bezier_curve_to(
  self : CanvasRenderingContext2D,
  cp1x : Double,
  cp1y : Double,
  cp2x : Double,
  cp2y : Double,
  x : Double,
  y : Double
) = "(self,cp1x,cp1y,cp2x,cp2y,x,y) => self.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::arc_to(
  self : CanvasRenderingContext2D,
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
  radius : Double
) = "(self,x1,y1,x2,y2,radius) => self.arcTo(x1,y1,x2,y2,radius)"

///|
pub extern "js" fn CanvasRenderingContext2D::rect(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.rect(x,y,w,h)"

///|
pub extern "js" fn CanvasRenderingContext2D::round_rect(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  w : Double,
  h : Double,
  // FIXME: support other types like DOMPointInit or sequence<double | DomPointInit>
  radius : Double
) = "(self,x,y,w,h,radius) => self.roundRect(x,y,w,h,radius)"

///|
pub extern "js" fn CanvasRenderingContext2D::arc(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  radius : Double,
  start_angle : Double,
  end_angle : Double,
  anticlockwise~ : Bool = false
) = "(self,x,y,radius,startAngle,endAngle,anticlockwise) => self.arc(x,y,radius,startAngle,endAngle,anticlockwise)"

///|
pub extern "js" fn CanvasRenderingContext2D::ellipse(
  self : CanvasRenderingContext2D,
  x : Double,
  y : Double,
  radius_x : Double,
  radius_y : Double,
  rotation : Double,
  start_angle : Double,
  end_angle : Double,
  anticlockwise~ : Bool = false
) = "(self,x,y,radiusX,radiusY,rotation,startAngle,endAngle,anticlockwise) => self.ellipse(x,y,radiusX,radiusY,rotation,startAngle,endAngle,anticlockwise)"

///|
type CanvasGradient

///|
pub extern "js" fn CanvasGradient::add_color_stop(
  self : CanvasGradient,
  offset : Double,
  color : String
) = "(self,offset,color) => self.addColorStop(offset,color)"

///|
type CanvasPattern

///|
pub extern "js" fn CanvasPattern::set_transform(
  self : CanvasPattern,
  transform : @js.Optional[DOMMatrix2DInit]
) = "(self,transform) => self.setTransform(transform)"

///|
type DOMMatrix2DInit

// TODO: add TextMetrics

///|
type ImageDataSettings

///| Possible values are "srgb" and "display-p3".
pub typealias PredefinedColorSpace = String

///|
pub extern "js" fn ImageDataSettings::new(
  color_space : PredefinedColorSpace
) -> ImageDataSettings = "(colorSpace) => ({colorSpace: colorSpace})"

///|
type ImageData

///|
pub extern "js" fn ImageData::new(
  sw : Int,
  sh : Int,
  settings : @js.Optional[ImageDataSettings]
) -> ImageData = "(sw,sh,settings) => new ImageData(sw,sh,settings)"

///|
pub extern "js" fn ImageData::new_with_data(
  data : Uint8ClampedArray,
  sw : Int,
  sh : Int,
  settings~ : @js.Optional[ImageDataSettings] = @js.Optional::undefined()
) -> ImageData = "(data,sw,sh,settings) => new ImageData(data,sw,sh,settings)"

///|
pub extern "js" fn ImageData::get_width(self : ImageData) -> Int = "(self) => self.width"

///|
pub extern "js" fn ImageData::get_height(self : ImageData) -> Int = "(self) => self.height"

///|
pub extern "js" fn ImageData::get_data(self : ImageData) -> Uint8ClampedArray = "(self) => self.data"

// TODO: support ImageData.data

///|
pub extern "js" fn ImageData::get_color_space(
  self : ImageData
) -> PredefinedColorSpace = "(self) => self.colorSpace"

///|
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

///|
type Uint8ClampedArray
