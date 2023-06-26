#include <Vmin_max.h>

extern "C" {
  // CONSTRUCTORS
  Vmin_max*
  min_max_new() {
    Vmin_max*ptr = new Vmin_max();
    return ptr;
  }

  void
  min_max_delete(Vmin_max* __ptr) {
    delete __ptr;
  }

  // API METHODS
  void
  min_max_eval(Vmin_max* __ptr) {
    __ptr->eval();
  }

  void
  min_max_trace(Vmin_max* __ptr, VerilatedVcdC* __tfp, int __levels) {
    __ptr->trace(__tfp, __levels);
  }

  void
  min_max_final(Vmin_max* __ptr) {
    __ptr->final();
  }

  // PORTS
  void
  min_max_set_clk(Vmin_max* __ptr, vluint8_t __v) {
    __ptr->clk = __v;
  }

  void
  min_max_set_reset(Vmin_max* __ptr, vluint8_t __v) {
    __ptr->reset = __v;
  }

  void
  min_max_set_start_port(Vmin_max* __ptr, vluint8_t __v) {
    __ptr->start_port = __v;
  }

  void
  min_max_set_Pd61(Vmin_max* __ptr, vluint32_t __v) {
    __ptr->Pd61 = __v;
  }

  void
  min_max_set_Pd62(Vmin_max* __ptr, vluint32_t __v) {
    __ptr->Pd62 = __v;
  }

  void
  min_max_set_Pd63(Vmin_max* __ptr, vluint32_t __v) {
    __ptr->Pd63 = __v;
  }

  void
  min_max_set_Pd64(Vmin_max* __ptr, vluint32_t __v) {
    __ptr->Pd64 = __v;
  }

  void
  min_max_set_M_Rdata_ram(Vmin_max* __ptr, vluint32_t __v) {
    __ptr->M_Rdata_ram = __v;
  }

  void
  min_max_set_M_DataRdy(Vmin_max* __ptr, vluint8_t __v) {
    __ptr->M_DataRdy = __v;
  }

  vluint8_t
  min_max_get_done_port(Vmin_max* __ptr) {
    return __ptr->done_port;
  }

  vluint8_t
  min_max_get_Mout_oe_ram(Vmin_max* __ptr) {
    return __ptr->Mout_oe_ram;
  }

  vluint8_t
  min_max_get_Mout_we_ram(Vmin_max* __ptr) {
    return __ptr->Mout_we_ram;
  }

  vluint32_t
  min_max_get_Mout_addr_ram(Vmin_max* __ptr) {
    return __ptr->Mout_addr_ram;
  }

  vluint32_t
  min_max_get_Mout_Wdata_ram(Vmin_max* __ptr) {
    return __ptr->Mout_Wdata_ram;
  }

  vluint8_t
  min_max_get_Mout_data_ram_size(Vmin_max* __ptr) {
    return __ptr->Mout_data_ram_size;
  }

}
