
// struct Updater[M] {
//   messages : @queue.T[M]
//   handler : (M) -> @command.T[M]
// }

// pub fn Updater::new[M](handler : (M) -> @command.T[M]) -> Updater[M] {
//   { messages: @queue.new(), handler }
// }

// pub fn trigger[M](self : Updater[M], message : M) -> Unit {
//   @queue.push(self.queue, message)
// }



