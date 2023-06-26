use rust_hdl::prelude::*;
use rust_hls_test_helpers::*;
use rust_hls_test_helpers::{hls_test, write_subject_result, write_test_result};
use std::{
    fs,
    sync::{Arc, Mutex},
};

const TEST_NAME: &str = "minmax_idiom_speed";

#[rust_hls_macro::hls]
pub mod min_max_hls {
    #[hls(
        bambu_flag = "--channels-type=MEM_ACC_11 --channels-number=1 -O5",
        rust_flag = "-C opt-level=3"
    )]
    #[allow(unused)]
    pub unsafe extern "C" fn min_max(
        elements: *const i32,
        num_elements: i32,
    ) -> rust_minmax::MinMaxResult {
        rust_minmax::minmax_idiomatic(elements, num_elements)
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

    write_subject_result(TEST_NAME, &average_cycles, &same_cycles_for_every_test);
}

fn run_test(test_name: &str, input: &[i32], expected_min: i32, expected_max: i32) -> usize {
    let input_length = input.len();
    let mut initial_memory: Vec<u32> = Vec::new();
    for &i in input {
        initial_memory.push(i as u32);
    }

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
                minmax.num_elements.next = input_length.to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                // println!("Return port: {:X?}", minmax.return_port.val().to_u64());
                let result = unsafe {
                    std::mem::transmute::<u64, rust_minmax::MinMaxResult>(
                        minmax.return_port.val().to_u64() as u64,
                    )
                };
                assert_eq!(result.min, expected_min as i32);
                assert_eq!(result.max, expected_max as i32);
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
