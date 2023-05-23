use rust_hdl::prelude::*;

// tag::rust-hdl-implementation[]
// tag::rust-hdl-struct[]
#[derive(LogicBlock)]
pub struct Blinker {
    pub clock: Signal<In, Clock>,
    pub blinker: Signal<Out, bool>,
    blinker_state: DFF<bool>,
    counter: DFF<Bits<32>>,
    delay: Constant<Bits<32>>,
}
// end::rust-hdl-struct[]

// tag::rust-hdl-constructor[]
impl Blinker {
    // Create a new blinker
    pub fn new(delay: u64) -> Self {
        Self {
            clock: Default::default(),
            blinker: Default::default(),
            blinker_state: Default::default(),
            counter: Default::default(),
            delay: Constant::new(delay.into()),
        }
    }
}
// end::rust-hdl-constructor[]

// tag::rust-hdl-logic[]
impl Logic for Blinker {
    #[hdl_gen]
    fn update(&mut self) {
        // Connect the D flip-flops to the clock
        self.counter.clock.next = self.clock.val();
        self.blinker_state.clock.next = self.clock.val();

        // Connect the inputs of the D flip-flops to their own outputs
        // This makes sure they are always driven
        self.counter.d.next = self.counter.q.val();
        self.blinker_state.d.next = self.blinker_state.q.val();

        // Connect the blinker output to the state D flip-flop
        self.blinker.next = self.blinker_state.q.val();

        // Increment the counter
        self.counter.d.next = self.counter.q.val() + 1u64.to_bits();

        // Reset the counter when it reaches the delay
        if self.counter.q.val() == self.delay.val() - 1 {
            self.blinker_state.d.next = !self.blinker_state.q.val();
            self.counter.d.next = 0u64.to_bits();
        }
    }
}
// end::rust-hdl-logic[]
// end::rust-hdl-implementation[]

// tag::rust-hdl-test[]
#[cfg(test)]
mod tests {
    use super::Blinker;
    use rust_hdl::prelude::*;

    #[test]
    fn blinker_works() {
        // <1>
        let blinker = Blinker::new(10);

        // <2>
        let mut simulation = Simulation::new();
        simulation.add_clock(1, |blinker: &mut Box<Blinker>| {
            blinker.clock.next = !blinker.clock.val()
        });

        // <3>
        simulation.add_testbench(move |mut sim: Sim<Blinker>| {
            let mut blinker = sim.init()?;

            for _cycle in 0..20 {
                sim_assert_eq!(sim, blinker.blinker.val(), false, blinker);
                wait_clock_cycles!(sim, clock, blinker, 10);
                sim_assert_eq!(sim, blinker.blinker.val(), true, blinker);
                wait_clock_cycles!(sim, clock, blinker, 10);
            }

            sim.done(blinker)
        });

        // <4>
        simulation
            .run_to_file(Box::new(blinker), 500, &vcd_path!("blinker_works.vcd"))
            .unwrap();
    }
}
// end::rust-hdl-test[]
