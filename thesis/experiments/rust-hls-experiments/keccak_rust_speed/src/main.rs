use rust_hdl::prelude::*;
use rust_hls_test_helpers::*;
use rust_hls_test_helpers::{hls_test, write_subject_result, write_test_result};
use std::{
    fs,
    sync::{Arc, Mutex},
};

const TEST_NAME: &str = "keccak_rust_speed";

#[rust_hls_macro::hls]
pub mod keccak_hls {
    #[hls(
        bambu_flag = "--channels-type=MEM_ACC_11 --channels-number=1 -O5 --target=/home/lennart/Documents/bachelor-thesis/thesis/experiments/device.xml",
        rust_flag = "-C opt-level=3",
        include_llvm_ir,
        include_logs
    )]
    #[allow(unused)]
    pub unsafe extern "C" fn keccak(input_pointer: *mut u64) {
        rust_keccak::keccak(input_pointer)
    }
}

fn main() {
    clear_reports();
    write_title_lines();
    let mut device = Keccak::default();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write(format!("./{}.v", TEST_NAME), data).expect("Unable to write file");

    let results = [
        run_test("only zeroes", [0u64; 25]),
        run_test("only deadbeef", [0xDeadbeefDeadbeefu64; 25]),
        run_test(
            "result of only zeroes again",
            [
                0xF1258F7940E1DDE7,
                0x84D5CCF933C0478A,
                0xD598261EA65AA9EE,
                0xBD1547306F80494D,
                0x8B284E056253D057,
                0xFF97A42D7F8E6FD4,
                0x90FEE5A0A44647C4,
                0x8C5BDA0CD6192E76,
                0xAD30A6F71B19059C,
                0x30935AB7D08FFC64,
                0xEB5AA93F2317D635,
                0xA9A6E6260D712103,
                0x81A57C16DBCF555F,
                0x43B831CD0347C826,
                0x01F22F1A11A5569F,
                0x05E5635A21D9AE61,
                0x64BEFEF28CC970F2,
                0x613670957BC46611,
                0xB87C5A554FD00ECB,
                0x8C3EE88A1CCF32C8,
                0x940C7922AE3A2614,
                0x1841F924A2C509E4,
                0x16F53526E70465C2,
                0x75F644E97F30A13B,
                0xEAF1FF7B5CECA249,
            ],
        ),
    ];
    let average_cycles = (results.iter().sum::<usize>() as f64) / (results.len() as f64);
    let same_cycles_for_every_test = results.iter().all(|&x| x == results[0]);

    write_subject_result(TEST_NAME, &average_cycles, &same_cycles_for_every_test);
}

fn run_test(test_name: &str, input: [u64; 25]) -> usize {
    let mut expected_result = input.clone();
    unsafe {
        let cloned_input_pointer = expected_result.as_mut_ptr();
        rust_keccak::keccak(cloned_input_pointer);
    }

    // TODO: This can be done better
    let cycles: Arc<Mutex<usize>> = Arc::new(Mutex::new(0));
    let cloned_cycles = cycles.clone();

    {
        hls_test!(
            Keccak,
            keccak,
            memory = input,
            u64,
            {
                // Setup
                keccak.input_pointer.next = 0u32.to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                assert_eq!(memory, expected_result);
                let mut thing = cloned_cycles.lock().unwrap();
                *thing = measured_cycles;
            },
            measured_cycles, // , "trace_abc.vcd"
            max_cycles = 1000000,
            vcd_file = &format!("{}.vcd", TEST_NAME)
        );
    }
    let thing = cycles.lock().unwrap();
    let cycles = thing.clone();
    write_test_result(TEST_NAME, test_name, &(cycles as f64));
    cycles
}
