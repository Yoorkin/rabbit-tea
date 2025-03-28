# Async Example

This example demonstrates how to manually wrap an async JS FFI in Moonbit. 

It's particularly useful when the functionality is not 
yet available in the rabbit-tea library. Ideally, the Core library should 
provide basic async utilities, but in this early stage, we need to implement 
the wrapping ourselves. 

If you are looking for HTTP request functionality, you can use the `rabbit-tea/http` package.

Run the example with the following command:

```bash
cd src/example/async
bash ./launch.sh
```

This command will build the project with js backend, and launch the server with node.
