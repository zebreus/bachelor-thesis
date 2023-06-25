/// Minmax function that is as similar as possible as the equivalent cpp function
#[rust_hls_macro::hls]
pub mod min_max_hls {
    #[hls(bambu_flag = "--channels-type=MEM_ACC_11 --channels-number=1")]
    /// Based on [bambu example](https://github.com/ferrandi/PandA-bambu/blob/main/documentation/tutorial_date_2022/bambu.ipynb)
    #[no_mangle]
    pub unsafe extern "C" fn min_max(
        elements: *mut i32,
        num_elements: i32,
        out_max: &mut i32,
        out_min: &mut i32,
    ) {
        let mut local_max = *elements.offset(0);
        let mut local_min = *elements.offset(0);
        for i in 0..num_elements {
            if *elements.offset(i as isize) > local_max {
                local_max = *elements.offset(i as isize);
            }
            if *elements.offset(i as isize) < local_min {
                local_min = *elements.offset(i as isize);
            }
        }
        *out_max = local_max;
        *out_min = local_min;
    }

    // tag::tests[]
    #[cfg(test)]
    mod tests {

        use super::min_max;

        #[test]
        fn minmax_works_as_expected() {
            let mut numbers: [i32; 25] = [
                0x21258F79, 0x34D5CCF9, 0x3598261E, 0x7D154730, 0x5B284E05, 0x5F97A42D, 0x10FEE5A0,
                0x2C5BDA0C, 0x4D30A6F7, 0x30935AB7, 0x4B5AA93F, 0x49A6E626, 0x61A57C16, 0x43B831CD,
                0x01F22F1A, 0x05E5635A, 0x64BEFEF2, 0x61367095, 0x787C5A55, 0x3C3EE88A, 0x040C7922,
                0x1841F924, 0x16F53526, 0x75F644E9, 0x3AF1FF7B,
            ];
            let mut result_max = 0;
            let mut result_min = 0;
            unsafe {
                let input_pointer: *mut i32 = std::mem::transmute(&mut numbers);
                min_max(input_pointer, 25, &mut result_max, &mut result_min);
            }
            assert_eq!(result_max, 0x7D154730);
            assert_eq!(result_min, 0x01F22F1A);
        }
    }
    // end::tests[]
}

#[allow(unused)]
macro_rules! init_hls {
    ($module: ident) => {
        $module.m_rdata_ram.next = 0xDEADBEEFu32.to_bits();
        $module.m_data_rdy.next = false.into();
        $module.reset.next = true.into();
        $module.start_port.next = true.into();
    };
}
#[allow(unused)]
macro_rules! function_complete {
    ($module: ident) => {
        $module.done_port.val()
    };
}
#[allow(unused)]
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
        let address = memory_address!($memory_size, mout_addr_ram, $memory.len());
        $module.m_rdata_ram.next = $memory[address].to_bits();
        if mout_we_ram == true {
            $memory[address] = mout_wdata_ram;
        }
    };
    ($sim: ident, $clock: ident, $module: ident) => {
        wait_clock_cycle!($sim, $clock, $module);
    };
}
#[allow(unused)]
macro_rules! wait_until_function_complete {
    ($sim: ident, $module: ident $(, $memory: ident, $memory_size: ident)? ) => {
        while !function_complete!($module) {
            wait_clock_cycle_with_memory!($sim, clk, $module $(, $memory, $memory_size)?);
        }
    };
}
#[allow(unused)]
macro_rules! hls_sim {
    ($module_type: ident, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:expr ;)* }, { $($verification:expr ;)* } $(,)?) => {
        {simple_sim!($module_type, clk, 1000000000, sim, {
            let mut $module = sim.init()?;
            init_hls!($module);

            $(let mut $memory: Vec<$memory_size> = $( if true { $initial_value.into() } else )? { vec![0; 1050] };)?


            $($preparation ;)*

            wait_until_function_complete!(sim, $module $(, $memory, $memory_size)?);

            $($verification ;)*

            sim.done($module)
        })}
    };
}
#[allow(unused)]
macro_rules! hls_test {
    ($module_type: ident, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:expr ;)* }, { $($verification:expr ;)* } $(,)?) => {
        let frequency = 1000000000;
        let mut simulation = hls_sim!($module_type, $module $(, $memory  $( = $initial_value)?, $memory_size)?, { $($preparation ;)* }, { $($verification ;)* });

        let hls_module = $module_type::new();
        let max_cycles = 1000;
        simulation
            .run(
                Box::new(hls_module),
                SIMULATION_TIME_ONE_SECOND / (frequency / max_cycles),
            )
            .unwrap();
    };
    ($module_type: ident, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:expr ;)* }, { $($verification:expr ;)* }, $vcd_file: expr) => {
        let frequency = 1000000000;
        let mut simulation = hls_sim!($module_type, $module $(, $memory $( = $initial_value)?, $memory_size)?, { $($preparation ;)* }, { $($verification ;)* } );

        let hls_module = $module_type::new();
        let max_cycles = 1000;
        simulation
            .run_to_file(
                Box::new(hls_module),
                SIMULATION_TIME_ONE_SECOND / (frequency / max_cycles),
                $vcd_file,
            )
            .unwrap();
    };
}

#[cfg(test)]
mod tests {
    use crate::minmax::MinMax;

    use rust_hdl::prelude::*;

    #[test]
    fn min_max_works() {
        hls_test!(
            MinMax,
            min_max,
            memory = [
                0x21258F79, 0x34D5CCF9, 0x3598261E, 0x7D154730, 0x5B284E05, 0x5F97A42D, 0x10FEE5A0,
                0x2C5BDA0C, 0x4D30A6F7, 0x30935AB7, 0x4B5AA93F, 0x49A6E626, 0x61A57C16, 0x43B831CD,
                0x01F22F1A, 0x05E5635A, 0x64BEFEF2, 0x61367095, 0x787C5A55, 0x3C3EE88A, 0x040C7922,
                0x1841F924, 0x16F53526, 0x75F644E9, 0x3AF1FF7B, 0, 0
            ],
            u32,
            {
                // Setup
                min_max.out_max.next = (4 * 26u32).to_bits();
                min_max.out_min.next = (4 * 25u32).to_bits();
                min_max.elements.next = 0u32.to_bits();
                min_max.num_elements.next = 25u32.to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                assert_eq!(memory[26], 0x7D154730);
                assert_eq!(memory[25], 0x01F22F1A);
            } // ,"trace_working.vcd"
        );
    }
}
