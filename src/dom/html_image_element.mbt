///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/fetchPriority
#external
type HTMLImageElement

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/Image
pub extern "js" fn HTMLImageElement::new() -> Self = "() => new Image()"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/Image
pub extern "js" fn HTMLImageElement::new_with_size(
  width : Double,
  height : Double
) -> Self = "(w,h) => new Image(w, h)"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/alt
pub extern "js" fn HTMLImageElement::get_alt(self : Self) -> String = "(self) => self.alt"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/alt
pub extern "js" fn HTMLImageElement::set_alt(self : Self, value : String) = "(self, value) => self.alt = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/complete
pub extern "js" fn HTMLImageElement::get_complete(self : Self) -> Bool = "(self) => self.complete"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/crossOrigin
pub extern "js" fn HTMLImageElement::get_cross_origin(self : Self) -> String = "(self) => self.crossOrigin"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/crossOrigin
pub extern "js" fn HTMLImageElement::set_cross_origin(
  self : Self,
  value : String
) = "(self, value) => self.crossOrigin = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/currentSrc
pub extern "js" fn HTMLImageElement::get_current_src(self : Self) -> String = "(self) => self.currentSrc"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/decoding
pub extern "js" fn HTMLImageElement::get_decoding(self : Self) -> String = "(self) => self.decoding"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/decoding
pub extern "js" fn HTMLImageElement::set_decoding(self : Self, value : String) = "(self, value) => self.decoding = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/height
pub extern "js" fn HTMLImageElement::get_height(self : Self) -> Double = "(self) => self.height"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/height
pub extern "js" fn HTMLImageElement::set_height(self : Self, value : Double) = "(self, value) => self.height = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/isMap
pub extern "js" fn HTMLImageElement::get_is_map(self : Self) -> Bool = "(self) => self.isMap"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/isMap
pub extern "js" fn HTMLImageElement::set_is_map(self : Self, value : Bool) = "(self, value) => self.isMap = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/loading
pub extern "js" fn HTMLImageElement::get_loading(self : Self) -> String = "(self) => self.loading"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/loading
pub extern "js" fn HTMLImageElement::set_loading(self : Self, value : String) = "(self, value) => self.loading = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/naturalHeight
pub extern "js" fn HTMLImageElement::get_natural_height(self : Self) -> Double = "(self) => self.naturalHeight"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/naturalHeight
pub extern "js" fn HTMLImageElement::set_natural_height(
  self : Self,
  value : Double
) = "(self, value) => self.naturalHeight = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/naturalWidth
pub extern "js" fn HTMLImageElement::get_natural_width(self : Self) -> Double = "(self) => self.naturalWidth"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/naturalWidth
pub extern "js" fn HTMLImageElement::set_natural_width(
  self : Self,
  value : Double
) = "(self, value) => self.naturalWidth = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/referrerPolicy
pub extern "js" fn HTMLImageElement::get_referrer_policy(self : Self) -> String = "(self) => self.referrerPolicy"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/referrerPolicy
pub extern "js" fn HTMLImageElement::set_referrer_policy(
  self : Self,
  value : String
) = "(self, value) => self.referrerPolicy = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/sizes
pub extern "js" fn HTMLImageElement::get_sizes(self : Self) -> String = "(self) => self.sizes"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/sizes
pub extern "js" fn HTMLImageElement::set_sizes(self : Self, value : String) = "(self, value) => self.sizes = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/src
pub extern "js" fn HTMLImageElement::get_src(self : Self) -> String = "(self) => self.src"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/src
pub extern "js" fn HTMLImageElement::set_src(self : Self, value : String) = "(self, value) => self.src = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/srcset
pub extern "js" fn HTMLImageElement::get_srcset(self : Self) -> String = "(self) => self.srcset"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/srcset
pub extern "js" fn HTMLImageElement::set_srcset(self : Self, value : String) = "(self, value) => self.srcset = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/useMap
pub extern "js" fn HTMLImageElement::get_use_map(self : Self) -> String = "(self) => self.useMap"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/useMap
pub extern "js" fn HTMLImageElement::set_use_map(self : Self, value : String) = "(self, value) => self.useMap = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/width
pub extern "js" fn HTMLImageElement::get_width(self : Self) -> Double = "(self) => self.width"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/width
pub extern "js" fn HTMLImageElement::set_width(self : Self, value : Double) = "(self, value) => self.width = value"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/x
pub extern "js" fn HTMLImageElement::get_x(self : Self) -> Double = "(self) => self.x"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/y
pub extern "js" fn HTMLImageElement::get_y(self : Self) -> Double = "(self) => self.y"

// TODO: Implement the decode method and promise handling.
// pub extern "js" fn HTMLImageElement::decode() -> Promise
