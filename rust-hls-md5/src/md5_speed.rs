/// Minmax function that is as similar as possible as the equivalent cpp function

#[rust_hls_macro::hls]
pub mod md5_hls {

    // tag::md5-implementation[]
    const SHIFT_PER_ROUND: [u32; 64] = [
        7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 5, 9, 14, 20, 5, 9, 14, 20, 5,
        9, 14, 20, 5, 9, 14, 20, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 6, 10,
        15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
    ];

    const K: [u32; 64] = [
        0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 0xf57c0faf, 0x4787c62a, 0xa8304613,
        0xfd469501, 0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be, 0x6b901122, 0xfd987193,
        0xa679438e, 0x49b40821, 0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa, 0xd62f105d,
        0x02441453, 0xd8a1e681, 0xe7d3fbc8, 0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
        0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a, 0xfffa3942, 0x8771f681, 0x6d9d6122,
        0xfde5380c, 0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70, 0x289b7ec6, 0xeaa127fa,
        0xd4ef3085, 0x04881d05, 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665, 0xf4292244,
        0x432aff97, 0xab9423a7, 0xfc93a039, 0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
        0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1, 0xf7537e82, 0xbd3af235, 0x2ad7d2bb,
        0xeb86d391,
    ];

    const A0: u32 = 0x67452301;
    const B0: u32 = 0xefcdab89;
    const C0: u32 = 0x98badcfe;
    const D0: u32 = 0x10325476;

    #[hls(
        bambu_flag = "--channels-type=MEM_ACC_11 --channels-number=1 -O5",
        rust_flag = "-C opt-level=3"
    )]
    pub unsafe extern "C" fn md5_speed(
        message_pointer: *const u32,
        result_pointer: *mut u32,
    ) -> () {
        let message = std::slice::from_raw_parts(message_pointer, 16);
        let mut a = A0; // A
        let mut b = B0; // B
        let mut c = C0; // C
        let mut d = D0; // D

        // for i from 0 to 63 do
        for i in 0u32..64 {
            // var int F, g
            let f: u32;
            let g: u32;

            match i {
                // if 0 ≤ i ≤ 15 then
                //     F := (B and C) or ((not B) and D)
                //     g := i
                0..=15 => {
                    f = (b & c) | ((!b) & d);
                    g = i;
                }
                // else if 16 ≤ i ≤ 31 then
                //     F := (D and B) or ((not D) and C)
                //     g := (5×i + 1) mod 16
                16..=31 => {
                    f = (d & b) | ((!d) & c);
                    g = (5 * i + 1) % 16;
                }
                // else if 32 ≤ i ≤ 47 then
                //     F := B xor C xor D
                //     g := (3×i + 5) mod 16
                32..=47 => {
                    f = b ^ c ^ d;
                    g = (3 * i + 5) % 16;
                }
                // else if 48 ≤ i ≤ 63 then
                //     F := C xor (B or (not D))
                //     g := (7×i) mod 16
                48..=63 => {
                    f = c ^ (b | (!d));
                    g = (7 * i) % 16;
                }
                _ => {
                    f = 0;
                    g = 0;
                }
            }

            // // Be wary of the below definitions of a,b,c,d
            // F := F + A + K[i] + M[g]  // M[g] must be a 32-bit block
            let current_message_data = message[g as usize];
            let rot = f
                .wrapping_add(a)
                .wrapping_add(K[i as usize])
                .wrapping_add(current_message_data);

            // A := D
            a = d;
            // D := C
            d = c;
            // C := B
            c = b;
            // B := B + leftrotate(F, s[i])
            b = b.wrapping_add(rot.rotate_left(SHIFT_PER_ROUND[i as usize]));
            // end for
        }

        a = a.wrapping_add(A0);
        b = b.wrapping_add(B0);
        c = c.wrapping_add(C0);
        d = d.wrapping_add(D0);

        let result = std::slice::from_raw_parts_mut(result_pointer, 4 as usize);
        result[0] = a;
        result[1] = b;
        result[2] = c;
        result[3] = d;
    }
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
    ($module_type: ident, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:stmt ;)* }, { $($verification:stmt ;)* } $(,)?) => {
        {simple_sim!($module_type, clk, 1000000000, sim, {
            let mut $module = sim.init()?;
            init_hls!($module);

            $(let mut $memory: Vec<$memory_size> = $( if true { $initial_value.into() } else )? { vec![0; 1050] };)?


            $($preparation)*

            wait_until_function_complete!(sim, $module $(, $memory, $memory_size)?);

            $($verification)*

            sim.done($module)
        })}
    };
}
#[allow(unused)]
macro_rules! hls_test {
    ($module_type: ident, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:stmt ;)* }, { $($verification:stmt ;)* } $(,)?) => {
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
    ($module_type: ident, $module: ident $(, $memory: ident $( = $initial_value: expr)?, $memory_size:ident)? , { $($preparation:stmt ;)* }, { $($verification:stmt ;)* }, $vcd_file: expr) => {
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
    use crate::encode_result::ToHashNumbers;

    use super::md5_hls::*;
    use super::Md5Speed;
    use crate::{encode_input::first_md5_block, encode_result::ToHashString};
    use rust_hdl::prelude::*;

    #[test]
    fn hashing_empty_string_from_manually_specified_input_generates_correct_result() {
        let input: [u32; 16] = [128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        unsafe {
            let input_pointer = &input as *const u32;
            let mut result = [0u32; 4];
            md5_speed(input_pointer, &mut result as *mut u32);
            assert_eq!(
                result.into_hash_string(),
                "d41d8cd98f00b204e9800998ecf8427e"
            )
        }
    }

    // tag::md5-test[]
    #[test]
    fn hashing_empty_string_generates_the_correct_result() {
        let input = first_md5_block("".as_bytes());
        let mut result = [0u32; 4];

        unsafe {
            md5_speed(&input as *const u32, &mut result as *mut u32);
        }

        assert_eq!(
            result.into_hash_string().as_str(),
            "d41d8cd98f00b204e9800998ecf8427e"
        )
    }

    #[test]
    fn hashing_a_generates_the_correct_result() {
        let input = first_md5_block("a".as_bytes());
        let mut result = [0u32; 4];

        unsafe {
            md5_speed(&input as *const u32, &mut result as *mut u32);
        }

        assert_eq!(
            result.into_hash_string().as_str(),
            "0cc175b9c0f1b6a831c399e269772661"
        )
    }
    // end::md5-test[]

    #[test]
    fn hashing_abc_generates_the_correct_result() {
        let input = first_md5_block("abc".as_bytes());
        let mut result = [0u32; 4];

        unsafe {
            md5_speed(&input as *const u32, &mut result as *mut u32);
        }

        assert_eq!(
            result.into_hash_string().as_str(),
            "900150983cd24fb0d6963f7d28e17f72"
        )
    }

    #[test]
    fn hashing_aaa_generates_the_correct_result() {
        let input = first_md5_block("aaa".as_bytes());
        let mut result = [0u32; 4];

        unsafe {
            md5_speed(&input as *const u32, &mut result as *mut u32);
        }

        assert_eq!(
            result.into_hash_string().as_str(),
            "47bce5c74f589f4867dbd57e9ca9f808"
        )
    }

    //     use rust_hdl::prelude::*;

    #[test]
    fn hls_hashing_empty_string_generates_the_correct_result() {
        let input: [u32; 16] = first_md5_block("".as_bytes());
        let expected_result = "d41d8cd98f00b204e9800998ecf8427e".into_hash_numbers();

        let mut backing_memory: [u32; 20] = [0; 20];
        backing_memory[0..16].copy_from_slice(&input);

        hls_test!(
            Md5Speed,
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
                assert_eq!(result, expected_result);
            },
            // "trace_empty_string.vcd"
        );
    }

    #[test]
    fn hls_hashing_abc_generates_the_correct_result() {
        let input: [u32; 16] = first_md5_block("abc".as_bytes());
        let expected_result = "900150983cd24fb0d6963f7d28e17f72".into_hash_numbers();

        let mut backing_memory: [u32; 20] = [0; 20];
        backing_memory[0..16].copy_from_slice(&input);

        hls_test!(
            Md5Speed,
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
                assert_eq!(result, expected_result);
            },
            // "trace_abc.vcd"
        );
    }
}
