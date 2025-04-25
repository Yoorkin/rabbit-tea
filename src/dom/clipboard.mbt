///|
pub extern type Clipboard

// TODO: support ClipboardItem
//
// ///|
// pub extern type ClipboardItem

// ///|
// pub extern "js" fn Clipboard::write(
//   self : Clipboard,
//   data : Array[ClipboardItem]
// ) =
//   #| (self,data) => self.write(data)

// ///|
// pub extern "js" fn Clipboard::read(self : Clipboard) -> @js.Promise =
//   #| (self) => self.read()

///|
pub extern "js" fn Clipboard::write_text(
  self : Clipboard,
  text : String
) -> @js.Promise =
  #| (self,text) => self.writeText(text)

///|
pub extern "js" fn Clipboard::read_text(self : Clipboard) -> @js.Promise =
  #| (self) => self.readText()
