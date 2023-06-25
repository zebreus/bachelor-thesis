mod memory;
pub mod minmax;

use memory::Memory;
use minmax::MinMax;
use rust_hdl::prelude::*;
use std::collections::BTreeMap;

#[derive(LogicBlock)]
struct TestBench {
    pub clock: Signal<In, Clock>,
    memory: Memory,
    min_max: MinMax,
}

impl TestBench {
    #[allow(unused)]
    pub fn new(values: BTreeMap<Bits<32>, Bits<32>>) -> Self {
        Self {
            clock: Default::default(),
            min_max: Default::default(),
            memory: Memory::new(values),
        }
    }
}

impl Logic for TestBench {
    #[hdl_gen]
    fn update(&mut self) {
        self.memory.clock.next = self.clock.val();
        self.min_max.clk.next = self.clock.val();
        self.min_max.reset.next = true.into();
        self.min_max.start_port.next = true.into();

        self.min_max.out_max.next = 22u32.to_bits();
        self.min_max.out_min.next = 21u32.to_bits();
        self.min_max.elements.next = 0u32.to_bits();
        self.min_max.num_elements.next = 20u32.to_bits();

        self.min_max.m_data_rdy.next = self.memory.m_data_rdy.val();
        self.min_max.m_rdata_ram.next = self.memory.m_rdata_ram.val();
        self.memory.mout_addr_ram.next = self.min_max.mout_addr_ram.val();
        self.memory.mout_data_ram_size.next = self.min_max.mout_data_ram_size.val();
        self.memory.mout_oe_ram.next = self.min_max.mout_oe_ram.val();
        self.memory.mout_we_ram.next = self.min_max.mout_we_ram.val();
        self.memory.mout_wdata_ram.next = self.min_max.mout_wdata_ram.val();
    }
}
