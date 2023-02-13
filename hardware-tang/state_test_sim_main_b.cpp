#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vstate_test.h"

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vstate_test *dut = new Vstate_test;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("state_test_b.vcd");

    while (sim_time < MAX_SIM_TIME) {
        dut->clk ^= 1;

        if(sim_time %6==0 && dut->start_port==0){
            dut->start_port = 1;
        }else {
            dut->start_port = 0;
        }
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}