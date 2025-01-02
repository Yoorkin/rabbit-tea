///|
pub extern "js" fn patch(element : Element) -> Unit =
  #| (element) => {
  #|   const app = document.getElementById("app");
  #|   while(app.firstChild) app.removeChild(app.firstChild);
  #|   app.appendChild(element);
  #| }
  #| 
  #|
