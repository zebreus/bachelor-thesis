use rust_hdl::prelude::*;

#[rust_hls_macro::hls]
pub mod your_module {
    #[hls(include_logs, include_llvm_ir)]
    pub extern "C" fn your_function(a: u32, b: u32) -> u32 {
        a * b
    }
}

pub fn main() {
    let mut device: YourFunction = YourFunction::new();
    device.connect_all();
    let data = generate_verilog(&device);
    std::fs::write("./multiplier.v", data).unwrap();
}

#[cfg(test)]
mod tests {
    use super::YourFunction;
    use rust_hdl::prelude::*;

    #[test]
    fn function_works() {
        let mut adder = YourFunction::default();
        adder.connect_all();

        let mut simulation = Simulation::new();

        simulation.add_testbench(move |mut sim: Sim<YourFunction>| {
            let mut adder = sim.init()?;

            adder.a.next = 4u32.to_bits();
            adder.b.next = 20u32.to_bits();

            wait_clock_cycle!(sim, clk, adder);

            sim_assert_eq!(sim, adder.return_port.val(), 84, adder);

            sim.done(adder)
        });

        simulation.run(Box::new(adder), 20).unwrap();
    }
}
