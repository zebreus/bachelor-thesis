extern "C" {
    
struct Leds {
    bool a;
    bool b;
    bool c;
    bool d;
};

Leds switch_cpp(int counter)
{
   Leds state = {0, 0, 0, 0};
   switch (counter) {
      case 0:
         state.a = 1;
         break;
      case 1:
         state.b = 1;
         break;
      case 2:
         state.c = 1;
         break;
      case 3:
         state.d = 1;
         break;
    default:
        break;
   }
   return state;
}

}