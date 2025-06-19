///|
#external
type HTMLDialogElement

///|
pub extern "js" fn HTMLDialogElement::open(self : Self) -> Bool = "(self) => self.open"

///|
pub extern "js" fn HTMLDialogElement::return_value(self : Self) -> String = "(self) => self.returnValue"

///|
pub extern "js" fn HTMLDialogElement::close(
  self : Self,
  return_value~ : @js.Optional[String] = @js.Optional::undefined()
) = "(self,returnValue) => self.close(returnValue)"

///|
pub extern "js" fn HTMLDialogElement::request_close(
  self : Self,
  return_value~ : @js.Optional[String] = @js.Optional::undefined()
) = "(self, returnValue) => self.requestClose(returnValue)"

///|
pub extern "js" fn HTMLDialogElement::show(self : Self) = "(self) => self.show()"

///|
pub extern "js" fn HTMLDialogElement::show_modal(self : Self) = "(self) => self.showModal()"
