use crate::{Section, SpannedErrorMessage};

/// Format a message that points at a single line
pub fn point_at_single_line(span: &Section, options: &SpannedErrorMessage) -> String {
    let Section {
        start,
        end,
        document,
        label,
    } = span;
    let line = start.line;

    let line_number_string = line.to_string();
    let empty_prefix = format!(" {} | ", " ".repeat(line_number_string.len()));
    let line_number_prefix = format!(" {} | ", line_number_string);
    let prefix_length = empty_prefix.len();
    let max_content_length = options.max_length - prefix_length;

    let mut lines = document.content.lines();
    let mut relevant_line = lines.nth(line - 1).unwrap().to_string();

    let start_column = start.column;
    let end_column = if start.line == end.line {
        end.column
    } else {
        std::cmp::min(start_column + options.max_length, relevant_line.len() + 1)
    };

    let offset = if end_column > max_content_length && start_column > options.minimum_start_distance
    {
        start_column - options.minimum_start_distance
    } else {
        0
    };
    relevant_line.drain(0..offset);
    relevant_line.truncate(max_content_length);
    let start_column = std::cmp::max(start_column - offset, 0);
    let end_column = std::cmp::min(end_column - offset, max_content_length);

    let remaining_space_after_arrows = max_content_length - end_column;

    // TODO: The label part is really hacky, but it works for now
    // Probalbly a good idea to add a function that splits a string into lines by line length and just breaking at spaces
    let lines_after_arrows: Vec<String> = label
        .split("\n")
        .map(|v| {
            v.chars()
                .enumerate()
                .flat_map(|(i, c)| {
                    if i != 0 && i % remaining_space_after_arrows == 0 {
                        Some('|')
                    } else {
                        None
                    }
                    .into_iter()
                    .chain(std::iter::once(c))
                })
                .collect::<String>()
                .split("|")
                .map(|v| String::from(v))
                .collect::<Vec<String>>()
        })
        .flatten()
        .filter(|v| v.len() != 0)
        .collect();

    let arrows = " ".repeat(start_column)
        + &"^".repeat(end_column - start_column)
        + &(lines_after_arrows
            .get(0)
            .map(|v| String::from(" ") + &v)
            .unwrap_or("".to_owned()));

    let extra_lines = lines_after_arrows
        .iter()
        .skip(1)
        .map(|v| "\n".to_owned() + &empty_prefix + &" ".repeat(end_column) + " " + &v)
        .collect::<Vec<String>>()
        .join("");

    let result = format!(
        r#"{}
{}{}
{}{}{}"#,
        empty_prefix, line_number_prefix, relevant_line, empty_prefix, arrows, extra_lines
    );
    return result;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_point_at_message_single_line() {
        let test_span = Section::from_search(
            r#"toast"#,
            r#"#[attr]
mod toast {
    let x = 5;
}"#,
        )
        .unwrap();
        let message = point_at_single_line(&test_span, &SpannedErrorMessage::default());
        assert_eq!(
            message,
            r#"   | 
 2 | mod toast {
   |     ^^^^^"#
        );
    }

    #[test]
    fn test_long_message() {
        let test_span = Section::from_search(
            r#"WE_WANT_TO_HIGHLIGHT_THIS"#,
            r#"fn some_really_long_function_name(a_really_long_argument_name: u32, WE_WANT_TO_HIGHLIGHT_THIS: u32, another_really_long_argument_name: u32, yet_another_thing: u32 ) {"#,
        )
        .unwrap();
        let message =
            point_at_single_line(&test_span, &SpannedErrorMessage::default().max_length(40));
        assert_eq!(
            message,
            r#"   | 
 1 | e: u32, WE_WANT_TO_HIGHLIGHT_THIS: 
   |         ^^^^^^^^^^^^^^^^^^^^^^^^^"#
        );
    }

    #[test]
    fn test_label() {
        let test_span = Section::from_search(
            r#"WE_WANT_TO_HIGHLIGHT_THIS"#,
            r#"fn some_really_long_function_name(a_really_long_argument_name: u32, WE_WANT_TO_HIGHLIGHT_THIS: u32, another_really_long_argument_name: u32, yet_another_thing: u32 ) {"#,
        )
        .unwrap().label("this is a really long label that should be split into multiple lines");
        let message =
            point_at_single_line(&test_span, &SpannedErrorMessage::default().max_length(120));
        assert_eq!(
            message,
            r#"   | 
 1 | fn some_really_long_function_name(a_really_long_argument_name: u32, WE_WANT_TO_HIGHLIGHT_THIS: u32, another_really_
   |                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^ this is a really long 
   |                                                                                               label that should be s
   |                                                                                               plit into multiple lin
   |                                                                                               es"#
        );
    }
}
