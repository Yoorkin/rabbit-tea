# Rabbit-TEA

Web framework inspired by The Elm Architecture.

## Features

- Refactor Safety

    By leveraging *pattern matching* and *tagged union*, exhaustive checks provide 
    a better refactoring experience. MoonBit helps prevent common runtime errors 
    ensuring more robust and reliable code.

- Maintainable State

    The state is globally managed, making it easier to maintain the entire application.
    By utilizing persistent data structures from `moonbitlang/core/immut`, 
    you can implement advanced features such as undo/redo functionality with ease.

- Lightweight Runtime

    The generated JavaScript file is 33KB after minified for a project like 
    `src/example/counter`, including the virtual DOM.

## Basic Example

```moonbit
typealias Model = Int
let model = 0

enum Msg {
  Increment
  Decrement
}

fn update(msg : Msg, model : Model) -> (Command[Msg], Model) {
  match msg {
    Increment => (none(), model + 1)
    Decrement => (none(), model - 1)
  }
}

fn view(model : Model) -> Html[Msg] {
  div([
    h1([text(model.to_string())]),
    button(click=Msg::Increment, [text("+")]),
    button(click=Msg::Decrement, [text("-")]),
  ])
}

fn main {
  @tea.startup(model~, update~, view~)
}
```

For more examples, see the `src/example` directory.

# Getting started with TailwindCSS

see [rabbit-tea-tailwind template](https://github.com/Yoorkin/rabbit-tea-tailwind)


