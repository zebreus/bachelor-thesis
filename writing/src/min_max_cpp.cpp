void min_max_cpp(int* input, int input_length, int* out_max, int* out_min)
{
   int local_max = input[0];
   int local_min = input[0];
   int i = 0;
   for(i = 0; i < input_length; i++)
   {
      if(input[i] > local_max)
      {
         local_max = input[i];
      }
      if(input[i] < local_min)
      {
         local_min = input[i];
      }
   }
   *out_max = local_max;
   *out_min = local_min;
}