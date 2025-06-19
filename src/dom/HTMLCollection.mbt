///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#external
type HTMLCollection

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection/length
pub extern "js" fn HTMLCollection::get_length(self : Self) -> Double = "(self) => self.length"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection/item
pub extern "js" fn HTMLCollection::item(
  self : Self,
  index : Double
) -> @js.Nullable[Element] = "(self,index) => self.item(index)"

///| https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection/namedItem
pub extern "js" fn HTMLCollection::named_item(
  self : Self,
  key : String
) -> @js.Nullable[Element] = "(self,key) => self.namedItem(key)"
