#include <Vkeccak.h>

extern "C" {
  // CONSTRUCTORS
  Vkeccak*
  keccak_new() {
    Vkeccak*ptr = new Vkeccak();
    return ptr;
  }

  void
  keccak_delete(Vkeccak* __ptr) {
    delete __ptr;
  }

  // API METHODS
  void
  keccak_eval(Vkeccak* __ptr) {
    __ptr->eval();
  }

  void
  keccak_trace(Vkeccak* __ptr, VerilatedVcdC* __tfp, int __levels) {
    __ptr->trace(__tfp, __levels);
  }

  void
  keccak_final(Vkeccak* __ptr) {
    __ptr->final();
  }

  // PORTS
  void
  keccak_set_clk(Vkeccak* __ptr, vluint8_t __v) {
    __ptr->clk = __v;
  }

  void
  keccak_set_reset(Vkeccak* __ptr, vluint8_t __v) {
    __ptr->reset = __v;
  }

  void
  keccak_set_start_port(Vkeccak* __ptr, vluint8_t __v) {
    __ptr->start_port = __v;
  }

  void
  keccak_set_Pd260(Vkeccak* __ptr, vluint32_t __v) {
    __ptr->Pd260 = __v;
  }

  void
  keccak_set_M_Rdata_ram(Vkeccak* __ptr, vluint64_t __v) {
    __ptr->M_Rdata_ram = __v;
  }

  void
  keccak_set_M_DataRdy(Vkeccak* __ptr, vluint8_t __v) {
    __ptr->M_DataRdy = __v;
  }

  vluint8_t
  keccak_get_done_port(Vkeccak* __ptr) {
    return __ptr->done_port;
  }

  vluint8_t
  keccak_get_Mout_oe_ram(Vkeccak* __ptr) {
    return __ptr->Mout_oe_ram;
  }

  vluint8_t
  keccak_get_Mout_we_ram(Vkeccak* __ptr) {
    return __ptr->Mout_we_ram;
  }

  vluint32_t
  keccak_get_Mout_addr_ram(Vkeccak* __ptr) {
    return __ptr->Mout_addr_ram;
  }

  vluint64_t
  keccak_get_Mout_Wdata_ram(Vkeccak* __ptr) {
    return __ptr->Mout_Wdata_ram;
  }

  vluint8_t
  keccak_get_Mout_data_ram_size(Vkeccak* __ptr) {
    return __ptr->Mout_data_ram_size;
  }

}
