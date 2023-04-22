#[test]
fn tests() {
    let t = trybuild::TestCases::new();
    t.pass("tests/works_on_functions.rs");
    t.pass("tests/creates_rust_hdl_struct.rs");
    t.pass("tests/supports_flag_arguments.rs");
    t.compile_fail("tests/fails_on_unknown_arguments.rs");
}
