#[no_mangle]
pub unsafe fn switch_rust(counter: i16) -> [bool; 4] {
    // let mut state = ;
    let state: [bool; 4] = match counter {
        0 => [true, false, false, false],
        1 => [false, true, false, false],
        2 => [false, false, true, false],
        3 => [false, false, false, true],
        _ => [false, false, false, false],
    };
    state
}
