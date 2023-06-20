use rust_hdl::prelude::*;

/// The build script synthesizes this into an `adder_module_synthesized.rs` file
///
/// The macro inserts into the file.
/// ```
/// mod adder_module_synthesized;
/// use adder_module_synthesized::Adder;
/// ```
#[rust_hls::hls]
pub mod hls_module {
    #[hls]
    pub extern "C" fn multiplier(a: u32, b: u32) -> u32 {
        a * b
    }
}

pub fn main() {
    let mut device = Multiplier::new();
    device.connect_all();
    let data = generate_verilog(&device);
    std::fs::write("./multiplier.v", data).unwrap();
}

#[cfg(test)]
mod tests {
    use super::Multiplier;
    use rust_hdl::prelude::*;

    #[test]
    fn should_be_able_to_count_to_ten() {
        let mut adder = Multiplier::default();
        adder.connect_all();

        let mut simulation = Simulation::new();

        simulation.add_testbench(move |mut sim: Sim<Multiplier>| {
            let mut adder = sim.init()?;

            adder.a.next = 4u32.to_bits();
            adder.b.next = 20u32.to_bits();

            wait_clock_cycle!(sim, clk, adder);

            sim_assert_eq!(sim, adder.return_port.val(), 4 * 20, adder);

            sim.done(adder)
        });

        simulation.run(Box::new(adder), 20).unwrap();
    }
}
