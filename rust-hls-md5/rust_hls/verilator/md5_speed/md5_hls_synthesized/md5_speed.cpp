#include <Vmd5_speed.h>

extern "C" {
  // CONSTRUCTORS
  Vmd5_speed*
  md5_speed_new() {
    Vmd5_speed*ptr = new Vmd5_speed();
    return ptr;
  }

  void
  md5_speed_delete(Vmd5_speed* __ptr) {
    delete __ptr;
  }

  // API METHODS
  void
  md5_speed_eval(Vmd5_speed* __ptr) {
    __ptr->eval();
  }

  void
  md5_speed_trace(Vmd5_speed* __ptr, VerilatedVcdC* __tfp, int __levels) {
    __ptr->trace(__tfp, __levels);
  }

  void
  md5_speed_final(Vmd5_speed* __ptr) {
    __ptr->final();
  }

  // PORTS
  void
  md5_speed_set_clk(Vmd5_speed* __ptr, vluint8_t __v) {
    __ptr->clk = __v;
  }

  void
  md5_speed_set_reset(Vmd5_speed* __ptr, vluint8_t __v) {
    __ptr->reset = __v;
  }

  void
  md5_speed_set_start_port(Vmd5_speed* __ptr, vluint8_t __v) {
    __ptr->start_port = __v;
  }

  void
  md5_speed_set_Pd458(Vmd5_speed* __ptr, vluint32_t __v) {
    __ptr->Pd458 = __v;
  }

  void
  md5_speed_set_Pd459(Vmd5_speed* __ptr, vluint32_t __v) {
    __ptr->Pd459 = __v;
  }

  void
  md5_speed_set_M_Rdata_ram(Vmd5_speed* __ptr, vluint32_t __v) {
    __ptr->M_Rdata_ram = __v;
  }

  void
  md5_speed_set_M_DataRdy(Vmd5_speed* __ptr, vluint8_t __v) {
    __ptr->M_DataRdy = __v;
  }

  vluint8_t
  md5_speed_get_done_port(Vmd5_speed* __ptr) {
    return __ptr->done_port;
  }

  vluint8_t
  md5_speed_get_Mout_oe_ram(Vmd5_speed* __ptr) {
    return __ptr->Mout_oe_ram;
  }

  vluint8_t
  md5_speed_get_Mout_we_ram(Vmd5_speed* __ptr) {
    return __ptr->Mout_we_ram;
  }

  vluint32_t
  md5_speed_get_Mout_addr_ram(Vmd5_speed* __ptr) {
    return __ptr->Mout_addr_ram;
  }

  vluint32_t
  md5_speed_get_Mout_Wdata_ram(Vmd5_speed* __ptr) {
    return __ptr->Mout_Wdata_ram;
  }

  vluint8_t
  md5_speed_get_Mout_data_ram_size(Vmd5_speed* __ptr) {
    return __ptr->Mout_data_ram_size;
  }

}
