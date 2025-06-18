///| Create a command to show a dialog.
/// 
/// The `modal` argument determines whether the dialog is modal or not.
pub fn[M] show(id : String, modal~ : Bool = true) -> Cmd[M] {
  _ => {
    let dialog = @dom.document()
      .get_element_by_id(id)
      .to_option()
      .unwrap()
      .to_html_element()
      .to_option()
      .unwrap()
      .to_html_dialog_element()
      .to_option()
      .unwrap()
    if modal {
      dialog.show_modal()
    } else {
      dialog.show()
    }
  }
}

///| Create a command to close a dialog.
/// 
/// The `return_value` argument is the value that will be filled in the `close` message.
pub fn[M] close(id : String, return_value? : String) -> Cmd[M] {
  _ => {
    let dialog = @dom.document()
      .get_element_by_id(id)
      .to_option()
      .unwrap()
      .to_html_element()
      .to_option()
      .unwrap()
      .to_html_dialog_element()
      .to_option()
      .unwrap()
    dialog.close(return_value=@js.Optional::from_option(return_value))
  }
}

///| Create a command to request closing a dialog.
/// 
/// This command will not close the dialog immediately; it will trigger the 
/// `cancel` message.
/// 
/// The `return_value` argument is the value that will be filled in the `close` message.
pub fn[M] request_close(id : String, return_value? : String) -> Cmd[M] {
  _ => {
    let dialog = @dom.document()
      .get_element_by_id(id)
      .to_option()
      .unwrap()
      .to_html_element()
      .to_option()
      .unwrap()
      .to_html_dialog_element()
      .to_option()
      .unwrap()
    dialog.request_close(return_value=@js.Optional::from_option(return_value))
  }
}
