/// Converts a string to snake_case.
pub fn as_snake_case(name: &str) -> String {
    let prepared_name = String::from(
        name.replace(|ch: char| !ch.is_alphanumeric(), "_")
            .trim_matches('_'),
    );
    let mut result = String::new();
    let mut last_char = '_';
    for c in prepared_name.chars() {
        if c == '_' {
            if last_char != '_' {
                result.push('_');
            }
        } else if c.is_uppercase() {
            if last_char != '_' {
                result.push('_');
            }
            result.extend(c.to_lowercase());
        } else {
            result.push(c);
        }
        last_char = c;
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn converts_camel_case_to_snake_case() {
        assert_eq!(as_snake_case("FooBar"), "foo_bar");
        assert_eq!(as_snake_case("foo_bar"), "foo_bar");
        assert_eq!(as_snake_case("Foo_Bar"), "foo_bar");
        assert_eq!(as_snake_case("fooBar"), "foo_bar");
        assert_eq!(as_snake_case("fooBaR"), "foo_ba_r");
    }

    #[test]
    fn removes_duplicate_underscores() {
        assert_eq!(as_snake_case("foo____bar"), "foo_bar");
        assert_eq!(as_snake_case("Foo____Bar"), "foo_bar");
    }

    #[test]
    fn removes_trailing_and_leading_underscores() {
        assert_eq!(as_snake_case("_foo_bar_"), "foo_bar");
        assert_eq!(as_snake_case("_Foo_Bar_"), "foo_bar");
        assert_eq!(as_snake_case("_FooBar_"), "foo_bar");
    }

    #[test]
    fn converts_other_punctuation_to_underscores() {
        assert_eq!(
            as_snake_case("a/b!c@d#e%f^g&h*i(j)k_l+m=n-o"),
            "a_b_c_d_e_f_g_h_i_j_k_l_m_n_o"
        );
    }

    #[test]
    fn allcaps_works_as_expected() {
        assert_eq!(as_snake_case("ABCDE"), "a_b_c_d_e");
    }
}
