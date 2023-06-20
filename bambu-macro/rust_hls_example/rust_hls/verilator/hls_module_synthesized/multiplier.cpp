#include <Vmultiplier.h>

extern "C" {
  // CONSTRUCTORS
  Vmultiplier*
  multiplier_new() {
    Vmultiplier*ptr = new Vmultiplier();
    return ptr;
  }

  void
  multiplier_delete(Vmultiplier* __ptr) {
    delete __ptr;
  }

  // API METHODS
  void
  multiplier_eval(Vmultiplier* __ptr) {
    __ptr->eval();
  }

  void
  multiplier_trace(Vmultiplier* __ptr, VerilatedVcdC* __tfp, int __levels) {
    __ptr->trace(__tfp, __levels);
  }

  void
  multiplier_final(Vmultiplier* __ptr) {
    __ptr->final();
  }

  // PORTS
  void
  multiplier_set_clk(Vmultiplier* __ptr, vluint8_t __v) {
    __ptr->clk = __v;
  }

  void
  multiplier_set_reset(Vmultiplier* __ptr, vluint8_t __v) {
    __ptr->reset = __v;
  }

  void
  multiplier_set_start_port(Vmultiplier* __ptr, vluint8_t __v) {
    __ptr->start_port = __v;
  }

  void
  multiplier_set_Pd5(Vmultiplier* __ptr, vluint32_t __v) {
    __ptr->Pd5 = __v;
  }

  void
  multiplier_set_Pd6(Vmultiplier* __ptr, vluint32_t __v) {
    __ptr->Pd6 = __v;
  }

  vluint8_t
  multiplier_get_done_port(Vmultiplier* __ptr) {
    return __ptr->done_port;
  }

  vluint32_t
  multiplier_get_return_port(Vmultiplier* __ptr) {
    return __ptr->return_port;
  }

}
