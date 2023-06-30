#include <Vyour_function.h>

extern "C" {
  // CONSTRUCTORS
  Vyour_function*
  your_function_new() {
    Vyour_function*ptr = new Vyour_function();
    return ptr;
  }

  void
  your_function_delete(Vyour_function* __ptr) {
    delete __ptr;
  }

  // API METHODS
  void
  your_function_eval(Vyour_function* __ptr) {
    __ptr->eval();
  }

  void
  your_function_trace(Vyour_function* __ptr, VerilatedVcdC* __tfp, int __levels) {
    __ptr->trace(__tfp, __levels);
  }

  void
  your_function_final(Vyour_function* __ptr) {
    __ptr->final();
  }

  // PORTS
  void
  your_function_set_clk(Vyour_function* __ptr, vluint8_t __v) {
    __ptr->clk = __v;
  }

  void
  your_function_set_reset(Vyour_function* __ptr, vluint8_t __v) {
    __ptr->reset = __v;
  }

  void
  your_function_set_start_port(Vyour_function* __ptr, vluint8_t __v) {
    __ptr->start_port = __v;
  }

  void
  your_function_set_Pd5(Vyour_function* __ptr, vluint32_t __v) {
    __ptr->Pd5 = __v;
  }

  void
  your_function_set_Pd6(Vyour_function* __ptr, vluint32_t __v) {
    __ptr->Pd6 = __v;
  }

  vluint8_t
  your_function_get_done_port(Vyour_function* __ptr) {
    return __ptr->done_port;
  }

  vluint32_t
  your_function_get_return_port(Vyour_function* __ptr) {
    return __ptr->return_port;
  }

}
