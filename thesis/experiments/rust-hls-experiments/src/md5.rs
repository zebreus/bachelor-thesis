use rust_hdl::prelude::*;
use rust_hls_md5::md5::encode_result::ToHashString;
use rust_hls_md5::md5::{encode_input::first_md5_block, Md5};
use std::fs::{self};
use std::sync::{Arc, Mutex};

use crate::test_macros::{write_subject_result, write_test_result};
use crate::*;

pub fn run_experiments() {
    let mut device = Md5::default();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./md5.v", data).expect("Unable to write file");

    let results = [
        run_test("abc", "900150983cd24fb0d6963f7d28e17f72"),
        run_test("", "d41d8cd98f00b204e9800998ecf8427e"),
        run_test(
            "lorem ipsum dolor sit amet",
            "201730d4278e576b25515bd90c6072d3",
        ),
        run_test("test_string", "3474851a3410906697ec77337df7aae4"),
    ];
    let average_cycles = (results.iter().sum::<usize>() as f64) / (results.len() as f64);
    let same_cycles_for_every_test = results.iter().all(|&x| x == results[0]);

    write_subject_result("md5", &average_cycles, &same_cycles_for_every_test);
}

fn run_test(input: &str, expected_hash: &str) -> usize {
    let input_array: [u32; 16] = first_md5_block(input.as_bytes());
    let expected_result = expected_hash.to_string();

    let mut backing_memory: [u32; 20] = [0; 20];
    backing_memory[0..16].copy_from_slice(&input_array);

    // TODO: This can be done better
    let cycles: Arc<Mutex<usize>> = Arc::new(Mutex::new(0));
    let cloned_cycles = cycles.clone();

    {
        hls_test!(
            Md5,
            md5,
            memory = backing_memory,
            u32,
            {
                // Setup
                md5.message_pointer.next = 0u64.to_bits();
                md5.result_pointer.next = (16u32 * 4).to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                let result: [u32; 4] = memory[16..20].try_into().unwrap();
                assert_eq!(result.into_hash_string(), expected_result);
                // write_cycles("test_1", &cycles.to_string());
                let mut thing = cloned_cycles.lock().unwrap();
                *thing = measured_cycles;
            },
            measured_cycles // , "trace_abc.vcd"
        );
    }
    let thing = cycles.lock().unwrap();
    let cycles = thing.clone();
    write_test_result(
        "md5",
        &format!("test_with_input_{}", input),
        &(cycles as f64),
    );
    cycles
}
