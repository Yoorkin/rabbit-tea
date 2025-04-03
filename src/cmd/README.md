# Cmd

The `Cmd[Msg]` type represent a task that has not yet been executed. 
It's a side effect managed by the runtime. The only way to run the command 
is return it from the `update` function:

```mbt
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  match msg {
    Msg::Click(id) => {
      // create a command to tell rabbit-tea scroll to the element with the given id
      let cmd = @nav.scroll_to(id) 
      let updated_model = {...}
      (cmd, updated_model)
    }
  }
}
```

The `scroll_to` function creates a `cmd` value that is returned with the `updated_model`. This means the scrolling action does not occur immediately. Instead, it will scroll to the element with the specified `id` after the `updated_model` has been rendered.

# Design Considerations

Why do we wrap tasks in `Cmd` instead of running them immediately? Here are some reasons:

1. **Tasks Need to Run After the New Model Is Rendered**

    - As shown in the example above, the `scroll_to` function must execute after the new model is rendered. If it runs immediately, the scroll action may not work as expected.
    - For instance, you might need to update the UI to a loading state before fetching data. If the HTTP task is executed immediately, the app could lose responsiveness.

    You might ask: "Why not make the `update` function asynchronous so tasks can run asynchronously, allowing the UI to update between those tasks?" Here's another reason:

2. **Encourages users follows the *Single Source of Truth* Principle**

    The *single source of truth* principle ensures that the new model and view are computed based on a single, consistent model.

    If the `update` function were asynchronous, updates could overlap, leading to situations where one update process occurs before another is completed. This could result in inconsistent states or unexpected behavior.

    ```
               +---> update(msg1, old_model) ---> new_model1
               |  
    old_model--+
               |
               +---> update(msg2, old_model) ---> new_model2
    ```

    Now you have two models, `new_model1` and `new_model2`. Which model should be used in the view?

    In some other UI frameworks, this issue could occur. In rabbit-tea, it can be avoided by using the `Cmd` pattern. If you doesn't use asynchronous functions in update, e.g. `@cmd.attempt` and `@cmd.perform`, you will never met this problem.





