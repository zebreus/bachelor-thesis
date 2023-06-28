use std::fmt::Display;
use std::fs::{remove_file, OpenOptions};

#[allow(unused)]
#[macro_export]
macro_rules! init_hls {
    ($module: ident) => {
        $module.m_rdata_ram.next = 0xDEADBEEFu32.to_bits();
        $module.m_data_rdy.next = false.into();
        $module.reset.next = true.into();
        $module.start_port.next = true.into();
    };
}
#[allow(unused)]
#[macro_export]
macro_rules! function_complete {
    ($module: ident) => {
        $module.done_port.val()
    };
}
#[allow(unused)]
#[macro_export]
macro_rules! memory_address {
    ($memory_size:ident, $address: ident, $memory_length: expr) => {{
        let address_value = $address as usize / to_bytes!($memory_size);
        if address_value >= $memory_length {
            println!(
                "Address {} out of bounds. Wrapping around to {}",
                address_value,
                address_value % $memory_length
            );
        }
        address_value % $memory_length
    }};
}
#[allow(unused)]
#[macro_export]
macro_rules! to_bytes {
    (u128) => {
        16
    };
    (u64) => {
        8
    };
    (u32) => {
        4
    };
    (u16) => {
        2
    };
    (u8) => {
        1
    };
}
#[allow(unused)]
#[macro_export]
macro_rules! to_size {
    (u128, $bits: expr) => {
        $bits.to_u128()
    };
    (u64, $bits: expr) => {
        $bits.to_u64()
    };
    (u32, $bits: expr) => {
        $bits.to_u32()
    };
    (u16, $bits: expr) => {
        $bits.to_u16()
    };
    (u8, $bits: expr) => {
        $bits.to_u8()
    };
}

#[allow(unused)]
#[macro_export]
macro_rules! wait_clock_cycle_with_memory {
    ($sim: ident, $clock: ident, $module: ident, $memory: ident) => {
        wait_clock_cycle_with_memory!($sim, $clock, $module, $memory, u64)
    };
    ($sim: ident, $clock: ident, $module: ident, $memory: ident, $memory_size: ident) => {
        let mout_addr_ram = ($module.mout_addr_ram.val().to_u32()) as usize;
        // let mout_data_ram_size = adder.$module.mout_data_ram_size.val().to_u32() & 0b111111;
        let mout_we_ram = $module.mout_we_ram.val();
        let mout_wdata_ram = to_size!($memory_size, $module.mout_wdata_ram.val());

        wait_clock_cycle!($sim, $clock, $module);
        // let mout_oe_ram = $module.mout_oe_ram.val();
        // TODO: Divide in rising and falling edge
        if $memory.len() != 0 {
            let address = memory_address!($memory_size, mout_addr_ram, $memory.len());
            $module.m_rdata_ram.next = $memory[address].to_bits();
            if mout_we_ram == true {
                $memory[address] = mout_wdata_ram;
            }
        } else {
            $module.m_rdata_ram.next = (0 as $memory_size).to_bits();
        }
    };
    ($sim: ident, $clock: ident, $module: ident) => {
        wait_clock_cycle!($sim, $clock, $module);
    };
}
#[allow(unused)]
#[macro_export]
macro_rules! wait_until_function_complete {
    ($sim: ident, $module: ident $(, $memory: ident, $memory_size: ident)? ) => {{
        let mut cycles = 0;
        while !function_complete!($module) {
            wait_clock_cycle_with_memory!($sim, clk, $module $(, $memory, $memory_size)?);
            cycles += 1;
        }
        cycles
    }};
}
#[allow(unused)]
#[macro_export]
macro_rules! hls_sim {
    ($module_type: ty, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:stmt ;)* }, { $($verification:stmt ;)* } $(, $cycles: ident)? $(,)?) => {
        {
            simple_sim!($module_type, clk, 1000000000, sim, {
            let mut $module = sim.init()?;
            init_hls!($module);

            $(let mut $memory: Vec<$memory_size> = $( if true { $initial_value.into() } else )? { vec![0; 1050] };)?


            $($preparation ;)*

            $(let $cycles = )* wait_until_function_complete!(sim, $module $(, $memory, $memory_size)?);

            $($verification ;)*

            sim.done($module)
        })}
    };
}
#[allow(unused)]
#[macro_export]
macro_rules! hls_test {
    ($module_type: ty, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:stmt ;)* }, { $($verification:stmt ;)* } $(, $cycles: ident)? $(, max_cycles = $max_cycles: expr)? $(,)?) => {
        let frequency = 1000000000;
        let mut simulation = hls_sim!($module_type, $module $(, $memory  $( = $initial_value)?, $memory_size)?, { $($preparation ;)* }, { $($verification ;)* } $(, $cycles)?);

        let hls_module = <$module_type>::new();
        let max_cycles = $(if true {$max_cycles} else )? {1000};
        simulation
            .run(
                Box::new(hls_module),
                SIMULATION_TIME_ONE_SECOND / (frequency / max_cycles),
            )
            .unwrap();
    };
    ($module_type: ty, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:stmt ;)* }, { $($verification:stmt ;)* } $(, $cycles: ident)? $(, max_cycles = $max_cycles: expr)? , vcd_file = $vcd_file: expr $(,)?  ) => {
        let frequency = 1000000000;
        let mut simulation = hls_sim!($module_type, $module $(, $memory $( = $initial_value)?, $memory_size)?, { $($preparation ;)* }, { $($verification ;)* } $(, $cycles)?);

        let hls_module = $module_type::new();
        let max_cycles = $(if true {$max_cycles} else )? {1000};
        simulation
            .run_to_file(
                Box::new(hls_module),
                SIMULATION_TIME_ONE_SECOND / (frequency / max_cycles),
                $vcd_file,
            )
            .unwrap();
    };
}

use std::io::prelude::*;

pub fn write_test_result(subject: impl Display, test_name: impl Display, cycles: impl Display) {
    let mut file = OpenOptions::new()
        .write(true)
        .append(true)
        .create(true)
        .open("result-tests-individual.csv")
        .unwrap();

    if let Err(e) = writeln!(file, "{},{},{}", subject, test_name, cycles) {
        eprintln!("Couldn't write to file: {}", e);
    }
}

pub fn write_subject_result(
    subject: impl Display,
    cycles: impl Display,
    same_cycles_for_every_test: impl Display,
) {
    let mut file = OpenOptions::new()
        .write(true)
        .append(true)
        .create(true)
        .open("result-subject.csv")
        .unwrap();

    if let Err(e) = writeln!(
        file,
        "{},{},{}",
        subject, cycles, same_cycles_for_every_test
    ) {
        eprintln!("Couldn't write to file: {}", e);
    }
}

pub fn clear_reports() {
    remove_file("result-tests-individual.csv").ok();
    remove_file("result-subject.csv").ok();
}

pub fn write_title_lines() {
    // write_test_result("subject", "test_name", &"duration");
    // write_subject_result("subject", &"duration", &"constant_duration");
}
