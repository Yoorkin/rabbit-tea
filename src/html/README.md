
# Html 

This package provides the helper functions to build Html.

Here are some design choices:

- Guide Users with Type Definitions

  This package defines specific types for arguments instead of relying on a potentially confusing `String` type. These types serve as documentation, helping users understand how to correctly provide arguments.

- Seamless HTML EDSL

  Instead of relying on a precompiler to process JSX-like syntax, this EDSL allows users to leverage the full power of Moonbit's syntax and toolchain. 
    
  You can embed expressions in views without needing escape characters like `property={expression}` or `:property=expression`. For cases where the property name matches the variable name, you can use the convenient name-punning syntax, such as `property?` or `property~`.

  In this early stage, we need to focus on improving the functionality of Rabbit-TEA. Language extensions like JSX may be considered after the 1.0 release.

- Keep it simple

  No compile-time code translation or runtime reflection magic.

  
# Using the Html EDSL

We are trying to define wrapper functions for each HTML element. They all follow a form like this:

```mbt
pub fn div[M](
  style~ : Array[String] = [],
  id? : String,
  klass? : String,
  click? : M,
  childrens : Array[Html[M]]
) -> Html[M] 
```

**Note:** The `class` property in HTML is renamed to `klass` because `class` is a reserved word in MoonBit.

## The `text` element

To represent text in HTML, use the `text` function.

```mbt
let html = p([text("hello world")])
```

## The special `nothing` element

There is a special `nothing` element that does not represent an actual HTML element, it simply represents "nothing". This is particularly useful for handling multiple `Option` types in your model:

```mbt
fn bar(path : Path, tag : Option[Tag]){
  let path = foo(path)
  let tag = match tag {
    None => []
    Some(x) => [view(x)] // Yuck!
  }
  div([path] + tag) // Don't do this
}
```

```mbt
fn bar(path : Path, tag : Option[Tag]){
  let path = foo(path)
  let tag = match tag {
    None => nothing()
    Some(x) => view(x)  
  }
  div([path, tag]) // Use @html.nothing
}
```

## Advanced Usage

The wrapper functions and properties provided here may not cover all possible use cases. If you encounter missing functionality, feel free to file an issue or use the `node()` function as a workaround. The `node()` function allows you to manually specify the tag name, attributes, and children for your HTML element, offering flexibility for advanced or uncommon scenarios.

```mbt
let html = node(
  "div",
  [style("key","value"), property("id","key")],
  [child1, child2],
) 
```

Contributions to help us finish the missing wrappers or arguments are also welcome.




  







