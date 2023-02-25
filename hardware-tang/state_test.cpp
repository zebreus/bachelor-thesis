extern "C" {
    
int state_test(int timer){
   static int i = 0;
   static int b = 0;
   b = (b + 1);
   bool c =( b % 13500000) == 0;
   if (c){
    b = 0;
    i++;
   }
   return i;
}

}

#ifdef TEST_CPP
#include <iostream>
int main() {
    std::cout << state_test() << "\n";
    std::cout << state_test() << "\n";
    std::cout << state_test() << "\n";
    std::cout << state_test() << "\n";
    return 0;
}
#endif