use rust_hdl::prelude::*;
use std::collections::BTreeMap;

/// Bambu memory block
#[derive(LogicBlock)]
pub struct Memory {
    pub clock: Signal<In, Clock>,
    pub m_rdata_ram: Signal<Out, Bits<32usize>>,
    pub m_data_rdy: Signal<Out, bool>,
    pub mout_oe_ram: Signal<In, bool>,
    pub mout_we_ram: Signal<In, bool>,
    pub mout_addr_ram: Signal<In, Bits<32usize>>,
    pub mout_wdata_ram: Signal<In, Bits<32usize>>,
    pub mout_data_ram_size: Signal<In, Bits<6usize>>,
    ram: RAM<Bits<32>, 32>,
}

impl Memory {
    pub fn new(values: BTreeMap<Bits<32>, Bits<32>>) -> Self {
        Self {
            clock: Signal::default(),
            m_rdata_ram: Signal::default(),
            m_data_rdy: Signal::default(),
            mout_oe_ram: Signal::default(),
            mout_we_ram: Signal::default(),
            mout_addr_ram: Signal::default(),
            mout_wdata_ram: Signal::default(),
            mout_data_ram_size: Signal::default(),
            ram: RAM::new(values),
        }
    }
}

impl Logic for Memory {
    #[hdl_gen] // <- this turns the update function into an HDL Kernel that can be turned into Verilog
    fn update(&mut self) {
        self.ram.read_clock.next = self.clock.val();
        self.ram.write_clock.next = self.clock.val();
        self.ram.write_enable.next = self.mout_we_ram.val();
        self.ram.write_address.next = self.mout_addr_ram.val();
        self.ram.read_address.next = self.mout_addr_ram.val();
        self.m_rdata_ram.next = self.ram.read_data.val();
        self.m_data_rdy.next = true.into();
        self.ram.write_data.next = self.mout_wdata_ram.val();

        //     self.ram.read_enable.next = self.mout_oe_ram.val();
        //     // v-- write to the .next member     v-- read from .val() method
        //     self.pulser.clock.next = self.clock.val();
        //     self.pulser.enable.next = true.into();
        //     self.led.next = self.pulser.pulse.val();
    }
}
