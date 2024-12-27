test "basic_url" {
  inspect!(
    @url.parse("https://example.com"),
    content=
      #|{protocol: Https, host: "example.com", port: None, path: "", query: None, fragment: None}
    ,
  )
  inspect!(
    @url.parse("https://example.com/"),
    content=
      #|{protocol: Https, host: "example.com", port: None, path: "", query: None, fragment: None}
    ,
  )
  inspect!(
    @url.parse("https://example.com/path1/path2"),
    content=
      #|{protocol: Https, host: "example.com", port: None, path: "path1/path2", query: None, fragment: None}
    ,
  )
  inspect!(
    @url.parse("https://example.com:8080/path/to/somewhere?query#fragment"),
    content=
      #|{protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: Some("query"), fragment: Some("fragment")}
    ,
  )
  inspect!(
    @url.parse("https://example.com:8080/path/to/somewhere?key=value&key2=value2#fragment"),
    content=
      #|{protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: Some("key=value&key2=value2"), fragment: Some("fragment")}
    ,
  )
}

test "no_port" {
  inspect!(
    @url.parse("https://example.com/path/to/somewhere?query#fragment"),
    content=
      #|{protocol: Https, host: "example.com", port: None, path: "path/to/somewhere", query: Some("query"), fragment: Some("fragment")}
    ,
  )
}

test "no_query" {
  inspect!(
    @url.parse("https://example.com:8080/path/to/somewhere#fragment"),
    content=
      #|{protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere#fragment", query: None, fragment: None}
    ,
  )
}

test "no_fragment" {
  inspect!(
    @url.parse("https://example.com:8080/path/to/somewhere?query"),
    content=
      #|{protocol: Https, host: "example.com", port: Some(8080), path: "path/to/somewhere", query: Some("query"), fragment: None}
    ,
  )
}
