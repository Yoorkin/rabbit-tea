// let callback_pool : Map[Int, () -> Unit] = {}

// let next_id : Ref[Int] = @ref.new(0)

// pub fn trigger_event(event : Int) -> Unit {
//   match callback_pool[event] {
//     Some(callback) => callback()
//     None => println("callback not found: \{event}")
//   }
// }

// fn add_event(event : Int, callback : () -> Unit) -> Unit {
//   callback_pool[event] = callback
// }

// type Event Int derive (Show)

// pub fn id(self : Event) -> Int {
//   self._
// }

// pub fn Event::new(callback : () -> Unit) -> Event {
//   let id = next_id.val
//   next_id.val += 1
//   add_event(id, callback)
//   Event(id)
// }
