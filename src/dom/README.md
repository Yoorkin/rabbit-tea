# DOM API 

This package provides incomplete API bindings for the DOM in the JavaScript backend.

Since the codegen tool for js binding is not yet available, the API is manually written. 
Rather than providing an elegant and convenient API, this package offers a low-level API that faithfully mirrors the underlying JavaScript DOM API while maintaining null-safety.

**Warning:** This package is not intended for the average Rabbit-TEA user. Using this API may result in losing cross-platform compatibility in the future.

# Naming Conventions and file structure

- All types and their associated methods are defined in corresponding files using `snake_case` naming style.
- For Types, use `CamelCase` naming.
- For methods, use `snake_case` naming.
    - If a method has multiple overloads, additional suffixes are appended to the method name based on the characteristics of the parameter list to avoid naming conflicts.
    - Do not define methods inherited from the parent type.
- For properties, they are encapsulated as methods with `set_` and `get_` prefixes.
- Optional parameters are set as labeled arguments and use the `@js.Optional[A]` type, with the default value set to `@js.Optional::undefined()`.
- For union types, depending on the number of parameters, use types like `@js.Union2[A, B]`, `@js.Union3[A, B, C]`, etc.
- For parameters or return values that may be `null`, use the `@js.Nullable[A]` type.
- For type conversions, use the `to_` prefix followed by the `snake_case` style type name:
    - For upcasting, directly return the converted type.
    - For downcasting, return the `@js.Nullable[A]` type. Use `arg instanceof A` to check if the conversion is valid; if valid, return the converted type, otherwise return `null`.
    - Only define the conversion methods for direct parent-child relationships in the inheritance hierarchy.

# Hierarchy of DOM Types

The partial inheritance hierarchy of DOM types in JavaScript is as follows: 

```plaintext
Event <-+-- ClipboardEvent
        +-- UIEvent <--+-- MouseEvent
                       +-- InputEvent
                       +-- FocusEvent
                       +-- KeyboardEvent

EventTarget <---+--Clipboard 
                +--Node <--+-- Document
                           +-- DocumentFragment
                           +-- Element <-- HTMLElement <--+-- HTMLCanvasElement
                                                          +-- HTMLInputElement
                                                          +-- HTMLDialogElement
                                                          +-- HTMLImageElement
```

# Troubleshooting

## I can't find the corresponding method

Since MoonBit does not have an inheritance mechanism, when calling methods, you need to first convert the type to the corresponding type.

For example, if you want to add an event listener to an instance of `HTMLElement`, you need to first convert it to the `EventTarget` type and then call the `add_event_listener` method.

## I can't find the corresponding type conversion function

For maintainability reasons, all type conversions can only occur between parent nodes and direct child nodes in the inheritance tree.

For example, if you want to convert a `Element` to a `HTMLCanvasElement`, you can do so using `x.to_html_element().to_html_canvas_element()`.


## Contribution 

Contributions to this DOM package are welcome! To ensure a smooth collaboration, please follow these guidelines:

- **Code Style**: Adhere to the naming conventions and file structure outlined above.
- **Documentation**: Update the README or add inline comments to document any new features or changes.
- **Pull Requests**: Include a link to the relevant MDN documentation for the API you implemented. Small, focused pull requests are preferred over large, complex ones.
- **Issue Reporting**: If you encounter bugs or have feature requests, please open an issue with detailed information.

