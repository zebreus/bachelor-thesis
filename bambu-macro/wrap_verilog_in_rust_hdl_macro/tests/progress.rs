#[test]
fn tests() {
    let t = trybuild::TestCases::new();
    t.pass("tests/parse_verilog.rs");
}
