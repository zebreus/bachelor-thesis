// tag::function[]
#include <limits.h>

void min_max(int *numbers, int numbers_length, int *out_max, int *out_min) {
  int local_max = INT_MIN;
  int local_min = INT_MAX;
  int i = 0;
  for (i = 0; i < numbers_length; i++) {
    if (numbers[i] > local_max) {
      local_max = numbers[i];
    }
    if (numbers[i] < local_min) {
      local_min = numbers[i];
    }
  }
  *out_max = local_max;
  *out_min = local_min;
}
// end::function[]