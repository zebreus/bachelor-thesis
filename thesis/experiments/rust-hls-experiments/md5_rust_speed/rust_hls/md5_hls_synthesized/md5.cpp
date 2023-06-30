#include <Vmd5.h>

extern "C" {
  // CONSTRUCTORS
  Vmd5*
  md5_new() {
    Vmd5*ptr = new Vmd5();
    return ptr;
  }

  void
  md5_delete(Vmd5* __ptr) {
    delete __ptr;
  }

  // API METHODS
  void
  md5_eval(Vmd5* __ptr) {
    __ptr->eval();
  }

  void
  md5_trace(Vmd5* __ptr, VerilatedVcdC* __tfp, int __levels) {
    __ptr->trace(__tfp, __levels);
  }

  void
  md5_final(Vmd5* __ptr) {
    __ptr->final();
  }

  // PORTS
  void
  md5_set_clk(Vmd5* __ptr, vluint8_t __v) {
    __ptr->clk = __v;
  }

  void
  md5_set_reset(Vmd5* __ptr, vluint8_t __v) {
    __ptr->reset = __v;
  }

  void
  md5_set_start_port(Vmd5* __ptr, vluint8_t __v) {
    __ptr->start_port = __v;
  }

  void
  md5_set_Pd500(Vmd5* __ptr, vluint32_t __v) {
    __ptr->Pd500 = __v;
  }

  void
  md5_set_Pd501(Vmd5* __ptr, vluint32_t __v) {
    __ptr->Pd501 = __v;
  }

  void
  md5_set_M_Rdata_ram(Vmd5* __ptr, vluint32_t __v) {
    __ptr->M_Rdata_ram = __v;
  }

  void
  md5_set_M_DataRdy(Vmd5* __ptr, vluint8_t __v) {
    __ptr->M_DataRdy = __v;
  }

  vluint8_t
  md5_get_done_port(Vmd5* __ptr) {
    return __ptr->done_port;
  }

  vluint8_t
  md5_get_Mout_oe_ram(Vmd5* __ptr) {
    return __ptr->Mout_oe_ram;
  }

  vluint8_t
  md5_get_Mout_we_ram(Vmd5* __ptr) {
    return __ptr->Mout_we_ram;
  }

  vluint32_t
  md5_get_Mout_addr_ram(Vmd5* __ptr) {
    return __ptr->Mout_addr_ram;
  }

  vluint32_t
  md5_get_Mout_Wdata_ram(Vmd5* __ptr) {
    return __ptr->Mout_Wdata_ram;
  }

  vluint8_t
  md5_get_Mout_data_ram_size(Vmd5* __ptr) {
    return __ptr->Mout_data_ram_size;
  }

}
