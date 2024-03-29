use rust_hdl::prelude::*;
use rust_hls_test_helpers::*;
use rust_hls_test_helpers::{hls_test, write_subject_result, write_test_result};
use std::{
    fs,
    sync::{Arc, Mutex},
};

const TEST_NAME: &str = "minmax_rust_size";

#[rust_hls_macro::hls]
pub mod min_max_hls {
    #[hls(
        bambu_flag = "--channels-type=MEM_ACC_11 --channels-number=1 -Os --target=/home/lennart/Documents/bachelor-thesis/thesis/experiments/device.xml",
        rust_flag = "-C opt-level=z"
    )]
    #[allow(unused)]
    pub unsafe extern "C" fn min_max(
        elements: *mut i32,
        elements_length: i32,
        out_max: &mut i32,
        out_min: &mut i32,
    ) {
        rust_minmax::minmax(elements, elements_length, out_max, out_min);
    }
}

fn main() {
    clear_reports();
    write_title_lines();
    let mut device = MinMax::default();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write(format!("./{}.v", TEST_NAME), data).expect("Unable to write file");

    let fifty_random_numbers: [i32; 50] = [
        -26, 354, 489, 165, -386, -498, -141, 285, 293, -151, -337, 464, 439, -426, 116, -435, 90,
        428, 178, 100, -258, 212, -228, 255, 288, 102, 199, -3, 224, -187, 317, -394, 125, 108,
        -167, -423, 432, -385, 37, 271, 330, -238, -308, -199, 422, 413, -11, -137, -146, 292,
    ];

    let mut results = vec![
        run_test("twentyfive zeroes", &[0i32; 25], 0, 0),
        run_test("twentyfive twentyfives", &[25i32; 25], 25, 25),
    ];

    let tests = (0..=50).map(|number_elements| {
        run_test(
            format!("length_{}", number_elements).as_str(),
            &fifty_random_numbers[0..number_elements],
            fifty_random_numbers[0..number_elements]
                .iter()
                .min()
                .cloned()
                .unwrap_or(i32::MAX)
                .clone(),
            fifty_random_numbers[0..number_elements]
                .iter()
                .max()
                .cloned()
                .unwrap_or(i32::MIN)
                .clone(),
        )
    });
    results.extend(tests);

    let average_cycles = (results.iter().sum::<usize>() as f64) / (results.len() as f64);
    let same_cycles_for_every_test: bool = results.iter().all(|&x| x == results[0]);

    write_subject_result(TEST_NAME, &average_cycles, &same_cycles_for_every_test);
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
                minmax.elements_length.next = input_length.to_bits();
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
    write_test_result(TEST_NAME, test_name, &(cycles as f64));
    cycles
}
