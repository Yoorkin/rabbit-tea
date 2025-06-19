///|
#external
type DataTransfer

///|
pub extern "js" fn DataTransfer::drop_effect(self : Self) -> String = "(t) => t.dropEffect"

///|
pub extern "js" fn DataTransfer::effect_allowed(self : Self) -> String = "(t) => t.effectAllowed"

///| 
pub extern "js" fn DataTransfer::items(self : Self) -> DataTransferItemList = "(t) => t.items"

///|
pub extern "js" fn DataTransfer::set_drog_image(
  self : Self,
  image : Element,
  x : Int,
  y : Int
) = "(t, image, x, y) => t.setDragImage(image, x, y)"

///|
#external
type DataTransferItemList

///|
pub extern "js" fn DataTransferItemList::length(self : Self) -> Int = "(l) => l.length"

///|
pub extern "js" fn DataTransferItemList::op_get(self : Self, index : Int) = "(l, i) => l[i]"

///|
pub extern "js" fn DataTransferItemList::add(
  self : Self,
  data : String,
  type_ : String
) = "(l, d, t) => l.add(d, t)"

///|
pub extern "js" fn DataTransferItemList::remove(self : Self, index : Int) = "(l, i) => l.remove(i)"

///|
pub extern "js" fn DataTransferItemList::clear(self : Self) = "(l) => l.clear()"
