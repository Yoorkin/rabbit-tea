///|
#external
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
pub extern "js" fn ImageData::get_width(self : Self) -> Int = "(self) => self.width"

///|
pub extern "js" fn ImageData::get_height(self : Self) -> Int = "(self) => self.height"

///|
pub extern "js" fn ImageData::get_data(self : Self) -> Uint8ClampedArray = "(self) => self.data"

// TODO: support ImageData.data

///|
pub extern "js" fn ImageData::get_color_space(
  self : ImageData
) -> PredefinedColorSpace = "(self) => self.colorSpace"

///| Possible values are "srgb" and "display-p3".
pub typealias String as PredefinedColorSpace
