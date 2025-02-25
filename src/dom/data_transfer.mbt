///|
extern type DataTransfer

///|
pub extern "js" fn DataTransfer::drop_effect(self : DataTransfer) -> String = "(t) => t.dropEffect"

///|
pub extern "js" fn DataTransfer::effect_allowed(self : DataTransfer) -> String = "(t) => t.effectAllowed"

///| 
pub extern "js" fn DataTransfer::items(
  self : DataTransfer
) -> DataTransferItemList = "(t) => t.items"

///|
pub extern "js" fn DataTransfer::set_drog_image(
  self : DataTransfer,
  image : Element,
  x : Int,
  y : Int
) = "(t, image, x, y) => t.setDragImage(image, x, y)"

///|
extern type DataTransferItemList

///|
pub extern "js" fn DataTransferItemList::length(
  self : DataTransferItemList
) -> Int = "(l) => l.length"

///|
pub extern "js" fn DataTransferItemList::op_get(
  self : DataTransferItemList,
  index : Int
) = "(l, i) => l[i]"

///|
pub extern "js" fn DataTransferItemList::add(
  self : DataTransferItemList,
  data : String,
  type_ : String
) = "(l, d, t) => l.add(d, t)"

///|
pub extern "js" fn DataTransferItemList::remove(
  self : DataTransferItemList,
  index : Int
) = "(l, i) => l.remove(i)"

///|
pub extern "js" fn DataTransferItemList::clear(self : DataTransferItemList) = "(l) => l.clear()"
