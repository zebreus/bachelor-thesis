//! A library for formatting error messages with spans
//!
//! This library is intended to be used outside of proc macros.
//!
//! # Examples
//!
//! From a file in a string
//!
//! ```
//! use spanned_error_message::{SpannedErrorMessage, Section};
//!
//! // A demo file loaded from a string
//! let file = r#"
//! pub fn foo(bar: u32) -> u32 {
//!     return String::from(bar * 2)
//! }
//! "#;
//!
//! // Section is equivalent to a Span in proc_macro.
//! let section = Section::from_search("String::from", file).unwrap();
//!
//! // Create the message
//! let message = SpannedErrorMessage::new()
//!     .create(&section);
//!
//! eprintln!("{}", message);
//! //    |
//! //  3 |     return String::from(bar * 2)
//! //    |            ^^^^^^^^^^^^
//! #
//! # // std::process::exit(1);
//! ```
//!
//! You can also convert a [proc_macro2::Span] into a section. Also you can load the content from a file.
//!
//! ```
//! use spanned_error_message::{SpannedErrorMessage, Section};
//!
//! // Replace this with your own span
//! let span = proc_macro2::Span::call_site();
//!
//! // Point the span to a file
//! let section = Section::from_span_and_path(&span, "src/lib.rs").unwrap();
//!
//! // Create a message
//! let message = SpannedErrorMessage::new()
//!     .create(&section);
//! ```
//!
//! With a label, title and reference to a file
//!
//! ```
//! use spanned_error_message::{SpannedErrorMessage, Section};
//!
//! // A demo file loaded from a string
//! let file = r#"
//! pub fn foo(bar: u32) -> u32 {
//!     return String::from(bar * 2)
//! }
//! "#;
//!
//! // Section is equivalent to a Span in proc_macro.
//! let mut section = Section::from_search("String::from", file).unwrap()
//!     .label("the problem is here");
//!
//! // Set the file path. This happens automatically if you load from a file instead of a string.
//! section.document.path = Some("src/lib.rs".into());
//!
//! let message = SpannedErrorMessage::new()
//!     .title("your code is broken")
//!     .create(&section);
//!
//! eprintln!("{}", message);
//! // error: your code is broken
//! //   --> src/lib.rs:3:11
//! //    |
//! //  3 |     return String::from(bar * 2)
//! //    |            ^^^^^^^^^^^^ your code is broken
//! #
//! # // std::process::exit(1);
//! ```
//!
//! Currently there is only support for single line pointers. If you have a multiline span, it will only point to the first line.

mod section;
pub use section::{Document, Location, Section};

mod point_at_file;
mod point_at_single_line;
mod title;

/// Settings for including the filename line
///
/// See [MessageOptions::include_filename]
pub enum IncludeFilename {
    /// Always include the filename line
    ///
    /// If the document has no filename, the default filename (`<unknown>`) will be used
    Always,
    /// Never include the filename line
    Never,
    /// Only include the filename line if the filename is a real file.
    ///
    /// If `document.path` is `None`, the filename line will not be included
    OnlyIfTheFilenameIsARealFile,
}

/// Options for the Messages
pub struct SpannedErrorMessage {
    /// The generated message will have a maximum length of this
    ///
    /// An exception for this are filename, which will never be broken
    pub max_length: usize,
    /// Minimum space before start when offsetting
    ///
    /// Example text
    /// ```text
    /// fn some_really_long_function_name(a_really_long_argument_name: u32, WE_WANT_TO_HIGHLIGHT_THIS: u32, another_really_long_argument_name: u32, yet_another_thing: u32 ) {
    /// ```
    ///
    /// with minimum_start_distance = 4
    ///
    /// ```text
    ///   | 32, WE_WANT_TO_HIGHLIGHT_THIS: u32, another_really_long_argument_name: u32, yet_another_thing: u32 ) {
    ///   |     ^^^^^^^^^^^^^^^^^^^^^^^^^
    /// ```
    ///
    /// with minimum_start_distance = 8
    ///
    /// ```text
    ///   | S: u32, WE_WANT_TO_HIGHLIGHT_THIS: u32, another_really_long_argument_name: u32, yet_another_thing: u32 ) {
    ///   |         ^^^^^^^^^^^^^^^^^^^^^^^^^
    /// ```
    pub minimum_start_distance: usize,
    /// Whether the message should include the filename line
    ///
    /// The default is to only include the filename if the path is known. ([IncludeFilename::OnlyIfTheFilenameIsARealFile])
    ///
    /// Example for a filename line
    ///
    /// ```text
    ///   ---> /home/username/project/src/main.rs:32:5
    /// ```
    ///
    /// If the filename is included, it will be placed after the title and before the pointers
    pub include_filename: IncludeFilename,
    /// The prefix for the title
    ///
    /// By default this is set to `error` but you can set it to anything else
    ///
    /// Example for a prefix of `really important`
    ///
    /// ```text
    /// really important: you could put your message here using .message("your message")
    /// ```
    ///
    /// The title is the first line of the message
    pub title_prefix: String,
    /// The title message
    ///
    /// By default this is set to `None`, so the title line will be omitted.
    ///
    /// Example: `title_message` is set to `Some("")`
    ///
    /// ```text
    /// error:
    /// ```
    ///
    /// Example: `title_message` is set to `Some("failed to compile a report about stuff")`
    ///
    /// ```text
    /// error: failed to compile a report about stuff
    /// ```
    ///
    /// The title is the first line of the message
    pub title_message: Option<String>,
}

impl Default for SpannedErrorMessage {
    fn default() -> Self {
        Self::new()
    }
}

impl SpannedErrorMessage {
    /// Create a new MessageOptions with default values
    pub fn new() -> Self {
        Self {
            max_length: 120,
            minimum_start_distance: 8,
            include_filename: IncludeFilename::OnlyIfTheFilenameIsARealFile,
            title_prefix: "error".into(),
            title_message: None,
        }
    }
    /// See [MessageOptions::minimum_start_distance]
    pub fn minimum_start_distance(&mut self, minimum_start_distance: usize) -> &mut Self {
        self.minimum_start_distance = minimum_start_distance;
        self
    }
    /// See [MessageOptions::max_length]
    pub fn max_length(&mut self, max_length: usize) -> &mut Self {
        self.max_length = max_length;
        self
    }
    /// Set include_filename to [IncludeFilename::Always]
    ///
    /// See [MessageOptions::include_filename]
    pub fn always_include_filename(&mut self) -> &mut Self {
        self.include_filename = IncludeFilename::Always;
        self
    }
    /// Set include_filename to [IncludeFilename::Never]
    ///
    /// See [MessageOptions::include_filename]
    pub fn never_include_filename(&mut self) -> &mut Self {
        self.include_filename = IncludeFilename::Never;
        self
    }
    /// Set include_filename to [IncludeFilename::OnlyIfTheFilenameIsARealFile]
    ///
    /// See [MessageOptions::include_filename]
    pub fn sometimes_include_filename(&mut self) -> &mut Self {
        self.include_filename = IncludeFilename::OnlyIfTheFilenameIsARealFile;
        self
    }
    /// See [MessageOptions::title_prefix]
    pub fn title_prefix(&mut self, title_prefix: impl Into<String>) -> &mut Self {
        self.title_prefix = title_prefix.into();
        self
    }
    /// Set [MessageOptions::title_message]
    pub fn title(&mut self, title_message: impl Into<String>) -> &mut Self {
        self.title_message = Some(title_message.into());
        self
    }
    /// Set [MessageOptions::title_message] to `None`
    pub fn no_title_message(&mut self) -> &mut Self {
        self.title_message = None;
        self
    }
    /// Create a message from a span
    pub fn create(&self, span: &Section) -> String {
        [
            title::title(self),
            point_at_file::point_at_file(span, self),
            Some(point_at_single_line::point_at_single_line(span, self)),
        ]
        .into_iter()
        .filter_map(|x| x)
        .reduce(|mut acc, x| {
            acc.push('\n');
            acc.push_str(&x);
            acc
        })
        .unwrap_or(String::new())
    }
}
