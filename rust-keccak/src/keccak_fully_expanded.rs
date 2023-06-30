/*
 * The Keccak sponge function, designed by Guido Bertoni, Joan Daemen,
 * Michaël Peeters and Gilles Van Assche. For more information, feedback or
 * questions, please refer to our website: http://keccak.noekeon.org/
 * Implementation by the designers,
 * hereby denoted as "the implementer".
 * To the extent possible under law, the implementer has waived all copyright
 * and related or neighboring rights to the source code in this file.
 * http://creativecommons.org/publicdomain/zero/1.0/
 *
 * This implementation is ported to more idiomatic rust compared to the other one.
 * Based on:
 * https://github.com/ferrandi/PandA-bambu/blob/main/examples/crypto_designs/Keccak.c
 */

use seq_macro::seq;

macro_rules! index {
    ($x:expr, $y:expr) => {
        (($x) % 5) + 5 * (($y) % 5)
    };
}

macro_rules! rol64 {
    ($a:expr, $offset:expr) => {
        (if ($offset != 0) {
            ((($a) << $offset) ^ (($a).wrapping_shr(64u32 - $offset)))
        } else {
            $a
        })
    };
}

macro_rules! one_round {
    ($a: ident, $round_constant:literal) => {
        seq!(x in 0..5 {
            let mut c_~x = $a[index!(x, 0)];
            seq!( y in 1..5 {
                c_~x ^= $a[index!(x, y)];
            });
        });

        let d_0 = rol64!(c_1, 1) ^ c_4;
        let d_1 = rol64!(c_2, 1) ^ c_0;
        let d_2 = rol64!(c_3, 1) ^ c_1;
        let d_3 = rol64!(c_4, 1) ^ c_2;
        let d_4 = rol64!(c_0, 1) ^ c_3;
        seq!( x in 0..5 {
            seq!( y in 0..5 {
                $a[index!(x, y)] ^= d_~x;
            });
        });

        $a[0] = rol64!($a[0],       0);
        $a[1] = rol64!($a[1],       1);
        $a[2] = rol64!($a[2],       62);
        $a[3] = rol64!($a[3],       28);
        $a[4] = rol64!($a[4],       27);
        $a[5] = rol64!($a[5],       36);
        $a[6] = rol64!($a[6],       44);
        $a[7] = rol64!($a[7],       6);
        $a[8] = rol64!($a[8],       55);
        $a[9] = rol64!($a[9],       20) ;
        $a[10] = rol64!($a[10],     3);
        $a[11] = rol64!($a[11],     10);
        $a[12] = rol64!($a[12],     43);
        $a[13] = rol64!($a[13],     25);
        $a[14] = rol64!($a[14],     39);
        $a[15] = rol64!($a[15],     41);
        $a[16] = rol64!($a[16],     45);
        $a[17] = rol64!($a[17],     15);
        $a[18] = rol64!($a[18],     21);
        $a[19] = rol64!($a[19],     8);
        $a[20] = rol64!($a[20],     18);
        $a[21] = rol64!($a[21],     2);
        $a[22] = rol64!($a[22],     61);
        $a[23] = rol64!($a[23],     56);
        $a[24] = rol64!($a[24],     14);

        seq!( x in 0..25 {
            let temp_a_~x : u64 = $a[x];
        });

        $a[((0 * 0 + 1 * 0) % 5) + 5 * ((2 * 0 + 3 * 0) % 5)] = temp_a_0;
        $a[((0 * 0 + 1 * 1) % 5) + 5 * ((2 * 0 + 3 * 1) % 5)] = temp_a_5;
        $a[((0 * 0 + 1 * 2) % 5) + 5 * ((2 * 0 + 3 * 2) % 5)] = temp_a_10;
        $a[((0 * 0 + 1 * 3) % 5) + 5 * ((2 * 0 + 3 * 3) % 5)] = temp_a_15;
        $a[((0 * 0 + 1 * 4) % 5) + 5 * ((2 * 0 + 3 * 4) % 5)] = temp_a_20;
        $a[((0 * 1 + 1 * 0) % 5) + 5 * ((2 * 1 + 3 * 0) % 5)] = temp_a_1;
        $a[((0 * 1 + 1 * 1) % 5) + 5 * ((2 * 1 + 3 * 1) % 5)] = temp_a_6;
        $a[((0 * 1 + 1 * 2) % 5) + 5 * ((2 * 1 + 3 * 2) % 5)] = temp_a_11;
        $a[((0 * 1 + 1 * 3) % 5) + 5 * ((2 * 1 + 3 * 3) % 5)] = temp_a_16;
        $a[((0 * 1 + 1 * 4) % 5) + 5 * ((2 * 1 + 3 * 4) % 5)] = temp_a_21;
        $a[((0 * 2 + 1 * 0) % 5) + 5 * ((2 * 2 + 3 * 0) % 5)] = temp_a_2;
        $a[((0 * 2 + 1 * 1) % 5) + 5 * ((2 * 2 + 3 * 1) % 5)] = temp_a_7;
        $a[((0 * 2 + 1 * 2) % 5) + 5 * ((2 * 2 + 3 * 2) % 5)] = temp_a_12;
        $a[((0 * 2 + 1 * 3) % 5) + 5 * ((2 * 2 + 3 * 3) % 5)] = temp_a_17;
        $a[((0 * 2 + 1 * 4) % 5) + 5 * ((2 * 2 + 3 * 4) % 5)] = temp_a_22;
        $a[((0 * 3 + 1 * 0) % 5) + 5 * ((2 * 3 + 3 * 0) % 5)] = temp_a_3;
        $a[((0 * 3 + 1 * 1) % 5) + 5 * ((2 * 3 + 3 * 1) % 5)] = temp_a_8;
        $a[((0 * 3 + 1 * 2) % 5) + 5 * ((2 * 3 + 3 * 2) % 5)] = temp_a_13;
        $a[((0 * 3 + 1 * 3) % 5) + 5 * ((2 * 3 + 3 * 3) % 5)] = temp_a_18;
        $a[((0 * 3 + 1 * 4) % 5) + 5 * ((2 * 3 + 3 * 4) % 5)] = temp_a_23;
        $a[((0 * 4 + 1 * 0) % 5) + 5 * ((2 * 4 + 3 * 0) % 5)] = temp_a_4;
        $a[((0 * 4 + 1 * 1) % 5) + 5 * ((2 * 4 + 3 * 1) % 5)] = temp_a_9;
        $a[((0 * 4 + 1 * 2) % 5) + 5 * ((2 * 4 + 3 * 2) % 5)] = temp_a_14;
        $a[((0 * 4 + 1 * 3) % 5) + 5 * ((2 * 4 + 3 * 3) % 5)] = temp_a_19;
        $a[((0 * 4 + 1 * 4) % 5) + 5 * ((2 * 4 + 3 * 4) % 5)] = temp_a_24;

        seq!( y in 0..5 {
            seq!( x in 0..5 {
                let c_~x = $a[index!(x, y)] ^ ((!$a[index!(x + 1, y)]) & $a[index!(x + 2, y)]);
            });
            seq!( x in 0..5 {
                $a[index!(x, y)] = c_~x;
            });
        });
        $a[0] ^= $round_constant;
    };
}

// #[inline(always)]
// fn theta(a: &mut [u64; 25]) -> () {}

// #[inline(always)]
// fn rho(a: &mut [u64; 25]) -> () {}

// #[inline(always)]
// fn pi(a: &mut [u64; 25]) -> () {}

// #[inline(always)]
// fn chi(a: &mut [u64; 25]) -> () {}

// fn iota(a: &mut [u64; 25], index_round: usize) -> () {
//     a[0] ^= get_krc_val!(index_round);
// }
pub unsafe extern "C" fn keccak_fully_expanded(a: *mut u64) -> () {
    let a: &mut [u64; 25] = std::mem::transmute(a);
    // for i in 0..NR_ROUNDS {
    //     theta(a);
    //     rho(a);
    //     pi(a);
    //     chi(a);
    //     iota(a, i);
    // }
    one_round!(a, 0x0000000000000001u64);
    one_round!(a, 0x0000000000008082u64);
    one_round!(a, 0x800000000000808au64);
    one_round!(a, 0x8000000080008000u64);
    one_round!(a, 0x000000000000808bu64);
    one_round!(a, 0x0000000080000001u64);
    one_round!(a, 0x8000000080008081u64);
    one_round!(a, 0x8000000000008009u64);
    one_round!(a, 0x000000000000008au64);
    one_round!(a, 0x0000000000000088u64);
    one_round!(a, 0x0000000080008009u64);
    one_round!(a, 0x000000008000000au64);
    one_round!(a, 0x000000008000808bu64);
    one_round!(a, 0x800000000000008bu64);
    one_round!(a, 0x8000000000008089u64);
    one_round!(a, 0x8000000000008003u64);
    one_round!(a, 0x8000000000008002u64);
    one_round!(a, 0x8000000000000080u64);
    one_round!(a, 0x000000000000800au64);
    one_round!(a, 0x800000008000000au64);
    one_round!(a, 0x8000000080008081u64);
    one_round!(a, 0x8000000000008080u64);
    one_round!(a, 0x0000000080000001u64);
    one_round!(a, 0x8000000080008008u64);
}

#[cfg(test)]
mod tests {

    use super::keccak_fully_expanded;

    #[test]
    fn hashing_zeroes_creates_expected_result() {
        let mut input = [0u64; 25];
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
            let input_pointer: *mut u64 = std::mem::transmute(&mut input);
            keccak_fully_expanded(input_pointer);
            assert_eq!(input, expected_result)
        }
    }
}
