///|
#external
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
pub extern "js" fn CanvasRenderingContext2D::save(self : Self) = "(x) => x.save()"

///|
pub extern "js" fn CanvasRenderingContext2D::restore(self : Self) = "(x) => x.restore()"

///|
pub extern "js" fn CanvasRenderingContext2D::reset(self : Self) = "(x) => x.reset()"

///|
pub extern "js" fn CanvasRenderingContext2D::is_context_lost(
  self : Self
) -> Bool = "() => x.isContextLost()"

///|
pub extern "js" fn CanvasRenderingContext2D::scale(
  self : Self,
  x : Double,
  y : Double
) = "(x,y) => x.scale(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::rotate(
  self : Self,
  angle : Double
) = "(x,angle) => x.rotate(angle)"

///|
pub extern "js" fn CanvasRenderingContext2D::translate(
  self : Self,
  x : Double,
  y : Double
) = "(x,y) => x.translate(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::transform(
  self : Self,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) = "(x,a,b,c,d,e,f) => x.transform(a,b,c,d,e,f)"

///|
pub extern "js" fn CanvasRenderingContext2D::set_transform(
  self : Self,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) = "(x,a,b,c,d,e,f) => x.setTransform(a,b,c,d,e,f)"

///|
pub extern "js" fn CanvasRenderingContext2D::reset_transform(self : Self) = "(x) => x.resetTransform()"

// TODO: add interface CanvasCompositing

///|
pub extern "js" fn CanvasRenderingContext2D::image_smoothing_enabled(
  self : Self
) -> Bool = "(x) => x.imageSmoothingEnabled"

///|
pub extern "js" fn CanvasRenderingContext2D::get_image_smoothing_quality(
  self : Self
) -> String = "(x) => x.imageSmoothingQuality"

///| Possible values are "low", "medium", and "high".
pub extern "js" fn CanvasRenderingContext2D::set_image_smoothing_quality(
  self : Self,
  value : String
) = "(x,value) => x.imageSmoothingQuality = value"

///|
pub extern "js" fn CanvasRenderingContext2D::get_stroke_style(
  self : Self
) -> @js.Union3[String, CanvasGradient, CanvasPattern] =
  #| (x) => x.strokeStyle

///|
pub extern "js" fn CanvasRenderingContext2D::set_stroke_style(
  self : Self,
  value : @js.Union3[String, CanvasGradient, CanvasPattern]
) =
  #| (x,value) => x.strokeStyle = value

///|
pub extern "js" fn CanvasRenderingContext2D::get_fill_style(
  self : Self
) -> @js.Union3[String, CanvasGradient, CanvasPattern] =
  #| (x) => x.fillStyle

///|
pub extern "js" fn CanvasRenderingContext2D::set_fill_style(
  self : Self,
  value : @js.Union3[String, CanvasGradient, CanvasPattern]
) =
  #| (x,value) => x.fillStyle = value

///|
pub extern "js" fn CanvasRenderingContext2D::create_linear_gradient(
  self : Self,
  x0 : Double,
  y0 : Double,
  x1 : Double,
  y1 : Double
) -> CanvasGradient = "(x,x0,y0,x1,y1) => x.createLinearGradient(x0,y0,x1,y1)"

///|
pub extern "js" fn CanvasRenderingContext2D::create_radial_gradient(
  self : Self,
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
  self : Self,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.clearRect(x,y,w,h)"

///|
pub extern "js" fn CanvasRenderingContext2D::fill_rect(
  self : Self,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.fillRect(x,y,w,h)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_rect(
  self : Self,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.stroke_rect(x,y,w,h)"

// TODO: add interface CanvasDrawPath

///|
pub extern "js" fn CanvasRenderingContext2D::begin_path(self : Self) = "(self) => self.beginPath()"

///|
pub extern "js" fn CanvasRenderingContext2D::fill(
  self : Self,
  fill_rule~ : String = "nonzero"
) = "(self, fillRule) => self.fill(fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::fill_path(
  self : Self,
  path : Path2D,
  fill_rule~ : String = "nonzero"
) = "(self,path,fillRule) => self.stroke(path,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke(self : Self) = "(self) => self.stroke()"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_with_path(
  self : Self,
  path : Path2D
) = "(self,path) => self.stroke(path)"

///|
pub extern "js" fn CanvasRenderingContext2D::clip(
  self : Self,
  fill_rule~ : String = "nonzero"
) = "(self, fillRule) => self.clip(fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::clip_with_path(
  self : Self,
  path : Path2D,
  fill_rule~ : String = "nonzero"
) = "(self,path,fillRule) => self.clip(path,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_path(
  self : Self,
  x : Double,
  y : Double,
  fill_rule~ : String = "nonzero"
) -> Bool = "(self,x,y,fillRule) => self.isPointInPath(x,y,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_path_with_path(
  self : Self,
  path : Path2D,
  x : Double,
  y : Double,
  fill_rule~ : String = "nonzero"
) -> Bool = "(self,path,x,y,fillRule) => self.isPointInPath(path,x,y,fillRule)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_stroke(
  self : Self,
  x : Double,
  y : Double
) -> Bool = "(self,x,y) => self.isPointInStroke(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::is_point_in_stroke_with_path(
  self : Self,
  path : Path2D,
  x : Double,
  y : Double
) -> Bool = "(self,path,x,y) => self.isPointInStroke(path,x,y)"

// TODO: add interface CanvasUserInterface

///|
pub extern "js" fn CanvasRenderingContext2D::fill_text(
  self : Self,
  text : String,
  x : Double,
  y : Double,
  max_width~ : @js.Optional[Double] = @js.Optional::undefined()
) = "(self,text,x,y,maxWidth) => self.fillText(text,x,y,maxWidth)"

///|
pub extern "js" fn CanvasRenderingContext2D::stroke_text(
  self : Self,
  text : String,
  x : Double,
  y : Double,
  max_width~ : @js.Optional[Double] = @js.Optional::undefined()
) = "(self,text,x,y,maxWidth) => self.strokeText(text,x,y,maxWidth)"

///| https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage
pub typealias @js.Union7[
  HTMLImageElement,
  SVGImageElement,
  HTMLVideoElement,
  HTMLCanvasElement,
  ImageBitmap,
  OffscreenCanvas,
  VideoFrame,
] as ImageUnion

///| https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage
pub extern "js" fn CanvasRenderingContext2D::draw_image(
  self : Self,
  image : ImageUnion,
  dx : Double,
  dy : Double
) = "(self,image,dx,dy) => self.drawImage(image,dx,dy)"

///| https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage
pub extern "js" fn CanvasRenderingContext2D::draw_image_with_size(
  self : Self,
  image : ImageUnion,
  dx : Double,
  dy : Double,
  dw : Double,
  dh : Double
) = "(self,image,dx,dy,dw,dh) => self.drawImage(image,dx,dy,dw,dh)"

///| https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage
pub extern "js" fn CanvasRenderingContext2D::draw_image_with_src_and_dst_size(
  self : Self,
  image : ImageUnion,
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
  self : Self,
  sw : Double,
  sh : Double,
  settings~ : @js.Optional[ImageDataSettings] = @js.Optional::undefined()
) -> ImageData = "(self,sw,sh,settings) => self.createImageData(sw,sh,settings)"

///|
pub extern "js" fn CanvasRenderingContext2D::create_image_data_with_data(
  self : Self,
  data : ImageData
) -> ImageData = "(self,data) => self.createImageData(data)"

///|
pub extern "js" fn CanvasRenderingContext2D::get_image_data(
  self : Self,
  sx : Double,
  sy : Double,
  sw : Double,
  sh : Double,
  settings~ : @js.Optional[ImageDataSettings] = @js.Optional::undefined()
) -> ImageData = "(self,sx,sy,sw,sh) => self.getImageData(sx,sy,sw,sh)"

///|
pub extern "js" fn CanvasRenderingContext2D::put_image_data(
  self : Self,
  image_data : ImageData,
  dx : Int,
  dy : Int
) = "(self,imageData,dx,dy) => self.putImageData(imageData,dx,dy)"

///|
pub extern "js" fn CanvasRenderingContext2D::put_image_data_with_dirty(
  self : Self,
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
  self : Self
) -> Double = "(self) => self.lineWidth"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_width(
  self : Self,
  value : Double
) = "(self,value) => self.lineWidth = value"

///|
pub extern "js" fn CanvasRenderingContext2D::get_line_cap(
  self : Self
) -> CanvasLineCap = "(self) => self.lineCap"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_cap(
  self : Self,
  value : CanvasLineCap
) = "(self,value) => self.lineCap = value"

///|
pub extern "js" fn CanvasRenderingContext2D::get_line_join(
  self : Self
) -> CanvasLineJoin = "(self) => self.lineJoin"

///|
pub extern "js" fn CanvasRenderingContext2D::set_line_join(
  self : CanvasRenderingContext2D,
  value : CanvasLineJoin
) = "(self,value) => self.lineJoin = value"

// TODO: add CanvasPathDrawingStyles.setLineDash, CanvasPathDrawingStyles.getLineDash, CanvasPathDrawingStyles.getLineDashOffset
// TODO: add CanvasTextDrawingStyles

///|
pub extern "js" fn CanvasRenderingContext2D::close_path(self : Self) = "(self) => self.closePath()"

///|
pub extern "js" fn CanvasRenderingContext2D::move_to(
  self : Self,
  x : Double,
  y : Double
) = "(self,x,y) => self.moveTo(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::line_to(
  self : Self,
  x : Double,
  y : Double
) = "(self,x,y) => self.lineTo(x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::quardratic_curve_to(
  self : Self,
  cpx : Double,
  cpy : Double,
  x : Double,
  y : Double
) = "(self,cpx,cpy,x,y) => self.quadraticCurveTo(cpx,cpy,x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::bezier_curve_to(
  self : Self,
  cp1x : Double,
  cp1y : Double,
  cp2x : Double,
  cp2y : Double,
  x : Double,
  y : Double
) = "(self,cp1x,cp1y,cp2x,cp2y,x,y) => self.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y)"

///|
pub extern "js" fn CanvasRenderingContext2D::arc_to(
  self : Self,
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
  radius : Double
) = "(self,x1,y1,x2,y2,radius) => self.arcTo(x1,y1,x2,y2,radius)"

///|
pub extern "js" fn CanvasRenderingContext2D::rect(
  self : Self,
  x : Double,
  y : Double,
  w : Double,
  h : Double
) = "(self,x,y,w,h) => self.rect(x,y,w,h)"

///|
pub extern "js" fn CanvasRenderingContext2D::round_rect(
  self : Self,
  x : Double,
  y : Double,
  w : Double,
  h : Double,
  // FIXME: support other types like DOMPointInit or sequence<double | DomPointInit>
  radius : Double
) = "(self,x,y,w,h,radius) => self.roundRect(x,y,w,h,radius)"

///|
pub extern "js" fn CanvasRenderingContext2D::arc(
  self : Self,
  x : Double,
  y : Double,
  radius : Double,
  start_angle : Double,
  end_angle : Double,
  anticlockwise~ : Bool = false
) = "(self,x,y,radius,startAngle,endAngle,anticlockwise) => self.arc(x,y,radius,startAngle,endAngle,anticlockwise)"

///|
pub extern "js" fn CanvasRenderingContext2D::ellipse(
  self : Self,
  x : Double,
  y : Double,
  radius_x : Double,
  radius_y : Double,
  rotation : Double,
  start_angle : Double,
  end_angle : Double,
  anticlockwise~ : Bool = false
) = "(self,x,y,radiusX,radiusY,rotation,startAngle,endAngle,anticlockwise) => self.ellipse(x,y,radiusX,radiusY,rotation,startAngle,endAngle,anticlockwise)"

///| https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/font 
pub extern "js" fn CanvasRenderingContext2D::get_font(self : Self) -> String = "(self) => self.font"

///| https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/font
pub extern "js" fn CanvasRenderingContext2D::set_font(
  self : Self,
  value : String
) = "(self,value) => self.font = value"
