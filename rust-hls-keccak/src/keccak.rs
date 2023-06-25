/// Minmax function that is as similar as possible as the equivalent cpp function

#[rust_hls_macro::hls]
pub mod keccak_hls {
    #[hls(bambu_flag = "--channels-type=MEM_ACC_11 --channels-number=1")]
    pub unsafe extern "C" fn keccak(input_pointer: *mut u64) -> () {
        let thing: &mut [u64; 25] = std::mem::transmute(input_pointer);
        ::keccak::f1600(thing);
    }

    // tag::tests[]
    #[cfg(test)]
    mod tests {

        use super::keccak;

        #[test]
        fn all_zeroes_get_hashed_correctly() {
            let mut input_pointer = [0u64; 25];
            let expected_result: [u64; 25] = [
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
            ];
            unsafe {
                let raw_input_pointer: *mut u64 = std::mem::transmute(&mut input_pointer);
                keccak(raw_input_pointer);
                assert_eq!(input_pointer, expected_result)
            }
        }
        #[test]
        fn real_value_get_hashed_correctly() {
            let mut input_pointer: [u64; 25] = [
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
            ];
            let expected_result: [u64; 25] = [
                0x2D5C954DF96ECB3C,
                0x6A332CD07057B56D,
                0x93D8D1270D76B6C,
                0x8A20D9B25569D094,
                0x4F9C4F99E5E7F156,
                0xF957B9A2DA65FB38,
                0x85773DAE1275AF0D,
                0xFAF4F247C3D810F7,
                0x1F1B9EE6F79A8759,
                0xE4FECC0FEE98B425,
                0x68CE61B6B9CE68A1,
                0xDEEA66C4BA8F974F,
                0x33C43D836EAFB1F5,
                0xE00654042719DBD9,
                0x7CF8A9F009831265,
                0xFD5449A6BF174743,
                0x97DDAD33D8994B40,
                0x48EAD5FC5D0BE774,
                0xE3B8C8EE55B7B03C,
                0x91A0226E649E42E9,
                0x900E3129E7BADD7B,
                0x202A9EC5FAA3CCE8,
                0x5B3402464E1C3DB6,
                0x609F4E62A44C1059,
                0x20D06CD26A8FBF5C,
            ];
            unsafe {
                let raw_input_pointer: *mut u64 = std::mem::transmute(&mut input_pointer);
                keccak(raw_input_pointer);
                assert_eq!(input_pointer, expected_result)
            }
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
    use crate::keccak::Keccak;

    use rust_hdl::prelude::*;

    #[test]
    fn all_zeroes_get_hashed_correctly() {
        let input_pointer: [u64; 25] = [0; 25];
        let expected_result: [u64; 25] = [
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
        ];

        hls_test!(
            Keccak,
            keccak,
            memory = input_pointer,
            u64,
            {
                // Setup
                keccak.input_pointer.next = 0u64.to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                assert_eq!(memory, expected_result);
            },
            // "trace_zeroes.vcd"
        );
    }

    #[test]
    fn real_value_get_hashed_correctly() {
        let input_pointer: [u64; 25] = [
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
        ];
        let expected_result: [u64; 25] = [
            0x2D5C954DF96ECB3C,
            0x6A332CD07057B56D,
            0x93D8D1270D76B6C,
            0x8A20D9B25569D094,
            0x4F9C4F99E5E7F156,
            0xF957B9A2DA65FB38,
            0x85773DAE1275AF0D,
            0xFAF4F247C3D810F7,
            0x1F1B9EE6F79A8759,
            0xE4FECC0FEE98B425,
            0x68CE61B6B9CE68A1,
            0xDEEA66C4BA8F974F,
            0x33C43D836EAFB1F5,
            0xE00654042719DBD9,
            0x7CF8A9F009831265,
            0xFD5449A6BF174743,
            0x97DDAD33D8994B40,
            0x48EAD5FC5D0BE774,
            0xE3B8C8EE55B7B03C,
            0x91A0226E649E42E9,
            0x900E3129E7BADD7B,
            0x202A9EC5FAA3CCE8,
            0x5B3402464E1C3DB6,
            0x609F4E62A44C1059,
            0x20D06CD26A8FBF5C,
        ];

        hls_test!(
            Keccak,
            keccak,
            memory = input_pointer,
            u64,
            {
                // Setup
                keccak.input_pointer.next = 0u64.to_bits();
            },
            {
                // Verification
                // println!("Memory: {:X?}", memory);
                assert_eq!(memory, expected_result);
            },
            // "trace_real.vcd"
        );
    }
}
