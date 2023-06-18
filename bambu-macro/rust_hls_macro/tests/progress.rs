#[test]
fn tests() {
    let t = trybuild::TestCases::new();
    // t.compile_fail("tests/fails_on_unknown_arguments.rs");
    // // t.compile_fail("tests/fails_on_hls_function_without_module.rs");
    // t.compile_fail("tests/fails_on_missing_hls_function.rs");
    // t.compile_fail("tests/fails_on_multiple_hls_function.rs");
    // t.compile_fail("tests/fails_on_nested_module.rs");
    // t.compile_fail("tests/hls_attribute_is_invalid_on_enum.rs");
    t.pass("tests/supports_flag_arguments.rs");
    t.pass("tests/simple_example.rs");
    t.pass("tests/works_with_module_named_like_function.rs");
}
