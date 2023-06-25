use rust_hdl::prelude::*;
use rust_hls_keccak::keccak::keccak_hls::keccak;
use rust_hls_keccak::keccak::Keccak;
use rust_hls_minmax::minmax::MinMax;
use seq_macro::seq;
use std::fs::{self};
use std::sync::{Arc, Mutex};

use crate::test_macros::{write_subject_result, write_test_result};
use crate::*;

pub fn run_experiments() {
    let mut device = MinMax::default();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./minmax.v", data).expect("Unable to write file");

    let fifty_random_numbers: [i32; 50] = [
        -26, 354, 489, 165, -386, -498, -141, 285, 293, -151, -337, 464, 439, -426, 116, -435, 90,
        428, 178, 100, -258, 212, -228, 255, 288, 102, 199, -3, 224, -187, 317, -394, 125, 108,
        -167, -423, 432, -385, 37, 271, 330, -238, -308, -199, 422, 413, -11, -137, -146, 292,
    ];

    let mut results = vec![
        run_test("twentyfive zeroes", &[0i32; 25], 0, 0),
        run_test("twentyfive twentyfives", &[25i32; 25], 25, 25),
    ];

    let tests = (1..50).map(|number_elements| {
        run_test(
            format!("length_{}", number_elements).as_str(),
            &fifty_random_numbers[0..number_elements],
            fifty_random_numbers[0..number_elements]
                .iter()
                .min()
                .unwrap()
                .clone(),
            fifty_random_numbers[0..number_elements]
                .iter()
                .max()
                .unwrap()
                .clone(),
        )
    });
    results.extend(tests);

    let average_cycles = (results.iter().sum::<usize>() as f64) / (results.len() as f64);
    let same_cycles_for_every_test: bool = results.iter().all(|&x| x == results[0]);

    write_subject_result("minmax", &average_cycles, &same_cycles_for_every_test);
}

fn run_test(test_name: &str, input: &[i32], expected_min: i32, expected_max: i32) -> usize {
    let input_length = input.len();
    let mut initial_memory: Vec<u32> = Vec::new();
    for &i in input {
        initial_memory.push(i as u32);
    }
    initial_memory.push(0u32);
    initial_memory.push(0u32);

    // TODO: This can be done better
    let cycles: Arc<Mutex<usize>> = Arc::new(Mutex::new(0));
    let cloned_cycles = cycles.clone();

    {
        hls_test!(
            MinMax,
            minmax,
            memory = initial_memory.clone(),
            u32,
            {
                // Setup
                minmax.elements.next = 0u32.to_bits();
                minmax.out_min.next = (input_length * 4).to_bits();
                minmax.out_max.next = ((input_length + 1) * 4).to_bits();
                minmax.num_elements.next = input_length.to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                assert_eq!(memory[(input_length) as usize], expected_min as u32);
                assert_eq!(memory[(input_length + 1) as usize], expected_max as u32);
                let mut thing = cloned_cycles.lock().unwrap();
                *thing = measured_cycles;
            },
            measured_cycles // , "trace_abc.vcd"
        );
    }
    let thing = cycles.lock().unwrap();
    let cycles = thing.clone();
    write_test_result("minmax", test_name, &(cycles as f64));
    cycles
}
