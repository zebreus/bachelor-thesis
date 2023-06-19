# spanned_error_message

<!-- cargo-rdme start -->

A library for formatting error messages with spans

This library is intended to be used outside of proc macros.

## Examples

From a file in a string

```rust
use spanned_error_message::{SpannedErrorMessage, Section};

// A demo file loaded from a string
let file = r#"
pub fn foo(bar: u32) -> u32 {
    return String::from(bar * 2)
}
"#;

// Section is equivalent to a Span in proc_macro.
let section = Section::from_search("String::from", file).unwrap();

// Create the message
let message = SpannedErrorMessage::new()
    .create(&section);

eprintln!("{}", message);
//    |
//  3 |     return String::from(bar * 2)
//    |            ^^^^^^^^^^^^
```

You can also convert a [proc_macro2::Span] into a section. Also you can load the content from a file.

```rust
use spanned_error_message::{SpannedErrorMessage, Section};

// Replace this with your own span
let span = proc_macro2::Span::call_site();

// Point the span to a file
let section = Section::from_span_and_path(&span, "src/lib.rs").unwrap();

// Create a message
let message = SpannedErrorMessage::new()
    .create(&section);
```

With a label, title and reference to a file

```rust
use spanned_error_message::{SpannedErrorMessage, Section};

// A demo file loaded from a string
let file = r#"
pub fn foo(bar: u32) -> u32 {
    return String::from(bar * 2)
}
"#;

// Section is equivalent to a Span in proc_macro.
let mut section = Section::from_search("String::from", file).unwrap()
    .label("the problem is here");

// Set the file path. This happens automatically if you load from a file instead of a string.
section.document.path = Some("src/lib.rs".into());

let message = SpannedErrorMessage::new()
    .title("your code is broken")
    .create(&section);

eprintln!("{}", message);
// error: your code is broken
//   --> src/lib.rs:3:11
//    |
//  3 |     return String::from(bar * 2)
//    |            ^^^^^^^^^^^^ your code is broken
```

Currently there is only support for single line pointers. If you have a multiline span, it will only point to the first line.

<!-- cargo-rdme end -->
