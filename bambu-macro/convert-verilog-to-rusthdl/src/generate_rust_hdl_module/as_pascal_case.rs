use super::as_snake_case::as_snake_case;

/// Converts a string to PascalCase.
pub fn as_pascal_case(name: &str) -> String {
    // Use snakecase as normalization
    let snake_case = as_snake_case(name);
    // Actual conversion
    let (_, pascal_case) = snake_case.chars().fold(
        (true, String::new()),
        |(uppercase_next, mut pascal_case), c| {
            if c == '_' {
                return (true, pascal_case);
            }
            if uppercase_next {
                pascal_case.extend(c.to_uppercase())
            } else {
                pascal_case.extend(c.to_lowercase())
            };
            return (false, pascal_case);
        },
    );
    pascal_case
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn converts_snake_case_to_pascal_case() {
        assert_eq!(as_pascal_case("foo_bar"), "FooBar");
        assert_eq!(as_pascal_case("foo$bar"), "FooBar");
        assert_eq!(as_pascal_case("_foo_bar_"), "FooBar");
        assert_eq!(as_pascal_case("_Foo_Bar_"), "FooBar");
    }

    #[test]
    fn removes_duplicate_underscores() {
        assert_eq!(as_pascal_case("foo____bar"), "FooBar");
    }

    #[test]
    fn converts_other_punctuation_to_uppercase() {
        assert_eq!(
            as_pascal_case("a/b!c@d#e%f^g&h*i(j)k_l+m=n-o"),
            "ABCDEFGHIJKLMNO"
        );
    }

    #[test]
    fn allcaps_works_as_expected() {
        assert_eq!(as_pascal_case("ABCDE"), "ABCDE");
    }
}
