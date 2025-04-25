///|
pub extern type Navigator

///|
pub extern "js" fn Navigator::clipboard(self : Navigator) -> Clipboard =
  #| (self) => self.clipboard
