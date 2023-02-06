extern "C" {

#include <cstdint>
    
struct Leds {
    uint32_t a;
    uint32_t b;
    uint32_t c;
    uint32_t d;
};

Leds switch_very_big_cpp(int counter)
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