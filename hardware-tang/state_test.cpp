extern "C" {
    
int state_test(){
   static int i = 0;
   i++;
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