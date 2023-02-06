extern "C" {

#include <cstdint>
    
struct Leds {
    uint16_t a;
    uint16_t b;
    uint16_t c;
    uint16_t d;
};

Leds switch_big_cpp(int counter)
{
   Leds state = {0, 0, 0, 0};
   switch (counter) {
      case 0:
         state.a = 1;
         break;
      case 1:
         state.b = 2;
         break;
      case 2:
         state.c = 4;
         break;
      case 3:
         state.d = 8;
         break;
    default:
        break;
   }
   return state;
}

}