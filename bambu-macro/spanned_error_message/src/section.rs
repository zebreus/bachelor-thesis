use std::{
    fs::read_to_string,
    path::{Path, PathBuf},
};

/// Represents a location in something file-like.
///
/// This is independent of the [Document].
///
/// # Examples
///
/// Create a new location at line 2, column 4
/// ```
/// # use spanned_error_message::Location;
/// #
/// let location = Location::new(2, 4);
/// ```
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash, Default)]
pub struct Location {
    /// The line in the location
    ///
    /// The first line is `1`
    pub line: usize,
    /// The column in the location
    ///
    /// `0` is before the first character of a line
    pub column: usize,
}

impl Location {
    /// Create a new location
    pub fn new(line: usize, column: usize) -> Self {
        Self { line, column }
    }
}

/// Represents the path and content of a file
///
/// # Examples
///
/// Create a document from a path
///
/// ```
/// # use spanned_error_message::Document;
/// #
/// let document = Document::from_path("Cargo.toml").unwrap();
/// ```
///
/// Create a document that has no real path
///
/// ```
/// # use spanned_error_message::Document;
/// #
/// let document = Document::from_content(r#"pub fn function() {
///     println!("hello {}", "world");
/// }"#);
/// ```
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash, Default)]
pub struct Document {
    /// The content of the file as a big string
    pub content: String,
    /// The path of the file
    ///
    /// Set to none if the path is unknown
    pub path: Option<PathBuf>,
}

impl Document {
    /// Load a document from a path
    pub fn from_path<P: AsRef<Path>>(path: P) -> Result<Self, std::io::Error> {
        let path = path.as_ref().to_path_buf();
        let content = read_to_string(&path)?;
        Ok(Self {
            content,
            path: Some(path),
        })
    }
    /// Create a new document with unknown path
    pub fn from_content(content: impl Into<String>) -> Self {
        Self {
            content: content.into(),
            path: None,
        }
    }
    /// Find a section of text in this document
    ///
    /// Returns `None` if the search string is not found in the document
    ///
    /// Returns a [Section] if the search string is found in the document. The section points to the first occurrence of the search string.
    ///
    /// # Examples
    ///
    /// Find `mod toast` in a document
    ///
    /// ```
    /// # use spanned_error_message::{Document, Section};
    /// #
    /// let document = Document::from_content(r#"#[attr]
    /// mod toast {
    ///     let x = 5;
    /// }"#);
    ///
    /// let section = document.find_section("mod toast").unwrap();
    ///
    /// assert_eq!(section.start.line, 2);
    /// assert_eq!(section.start.column, 0);
    /// assert_eq!(section.end.line, 2);
    /// assert_eq!(section.end.column, 9);
    /// ```
    pub fn find_section(&self, search: &str) -> Option<Section> {
        let cloned_document = self.clone();

        let start = cloned_document.content.find(search).unwrap();
        let end = start + search.len();
        let start = Location {
            line: cloned_document.content[..start].matches('\n').count() + 1,
            column: start
                - cloned_document.content[..start]
                    .rfind('\n')
                    .map(|v| v + 1)
                    .unwrap_or(0),
        };
        let end = Location {
            line: cloned_document.content[..end].matches('\n').count() + 1,
            column: end
                - cloned_document.content[..end]
                    .rfind('\n')
                    .map(|v| v + 1)
                    .unwrap_or(0),
        };
        Some(Section {
            start,
            end,
            document: cloned_document,
            label: String::new(),
        })
    }
}

/// Represents a span of text in a document.
///
/// It is similar to a [proc_macro2::Span], but it works on strings not on tokens.
///
/// It contains the whole file as a string.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash, Default)]
pub struct Section {
    /// Marks the start of the section
    pub start: Location,
    /// Marks the end of the section
    pub end: Location,
    /// start and end refer to locations in this document
    pub document: Document,
    /// A label for the section
    ///
    /// Will be used in the error message if set.
    ///
    /// By default this is an empty string
    pub label: String,
}

impl Section {
    /// Create a new section from a [proc_macro2::Span] and a path
    ///
    /// The span will be interpreted as a span in the document loaded from the path.
    ///
    /// # Examples
    ///
    /// ```
    /// # use spanned_error_message::Section;
    /// #
    /// # let your_span = proc_macro2::Span::call_site();
    /// #
    /// let section = Section::from_span_and_path(
    ///    &your_span,
    ///    "src/lib.rs"
    /// ).unwrap();
    /// ```
    ///
    /// This function is just a wrapper around [Section::from_span_and_document]
    pub fn from_span_and_path<P: AsRef<Path>>(
        span: &proc_macro2::Span,
        path: P,
    ) -> Result<Self, std::io::Error> {
        let document = Document::from_path(path)?;

        Ok(Self::from_span_and_document(span, document))
    }
    /// Create a new section from a [proc_macro2::Span] and a document
    ///
    /// The span will be interpreted as a span in the document.
    pub fn from_span_and_document(span: &proc_macro2::Span, document: Document) -> Self {
        let start = Location {
            line: span.start().line,
            column: span.start().column,
        };
        let end = Location {
            line: span.end().line,
            column: span.end().column,
        };

        Self {
            start,
            end,
            document,
            label: "".into(),
        }
    }
    /// Wrapper around [Document::find_section]
    pub fn from_search(search: &str, content: impl Into<String>) -> Option<Section> {
        let document = Document::from_content(content);
        document.find_section(search)
    }
    /// Set the label of the section
    pub fn label(mut self, label: impl Into<String>) -> Self {
        self.label = label.into();
        self
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_find_in_document() {
        let test_span = Section::from_search("toast", "mod toast {").unwrap();
        assert_eq!(test_span.start.line, 1);
        assert_eq!(test_span.start.column, 4);
        assert_eq!(test_span.end.line, 1);
        assert_eq!(test_span.end.column, 9);

        let test_span = Section::from_search(
            r#"toast"#,
            r#"#[attr]
mod toast {
    let x = 5;
}"#,
        )
        .unwrap();
        assert_eq!(test_span.start.line, 2);
        assert_eq!(test_span.start.column, 4);
        assert_eq!(test_span.end.line, 2);
        assert_eq!(test_span.end.column, 9);

        let test_span = Section::from_search(
            r#"toast {
    let x"#,
            r#"#[attr]
mod toast {
    let x = 5;
}"#,
        )
        .unwrap();
        assert_eq!(test_span.start.line, 2);
        assert_eq!(test_span.start.column, 4);
        assert_eq!(test_span.end.line, 3);
        assert_eq!(test_span.end.column, 9);

        let test_span = Section::from_search(
            r#"mod toast {"#,
            r#"#[attr]
mod toast {
    let x = 5;
}"#,
        )
        .unwrap();
        assert_eq!(test_span.start.line, 2);
        assert_eq!(test_span.start.column, 0);
        assert_eq!(test_span.end.line, 2);
        assert_eq!(test_span.end.column, 11);

        // Newline before
        let test_span = Section::from_search(
            r#"
mod toast {"#,
            r#"#[attr]
mod toast {
    let x = 5;
}"#,
        )
        .unwrap();
        assert_eq!(test_span.start.line, 1);
        assert_eq!(test_span.start.column, 7);
        assert_eq!(test_span.end.line, 2);
        assert_eq!(test_span.end.column, 11);

        // Newline after
        let test_span = Section::from_search(
            r#"mod toast {
"#,
            r#"#[attr]
mod toast {
    let x = 5;
}"#,
        )
        .unwrap();
        assert_eq!(test_span.start.line, 2);
        assert_eq!(test_span.start.column, 0);
        assert_eq!(test_span.end.line, 3);
        assert_eq!(test_span.end.column, 0);
    }
}
