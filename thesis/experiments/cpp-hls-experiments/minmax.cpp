void minmax(int *numbers, int numbers_length, int *out_max, int *out_min) {
  int local_max = numbers[0];
  int local_min = numbers[0];
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