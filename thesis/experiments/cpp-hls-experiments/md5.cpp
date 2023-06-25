// tag::md5-implementation[]
#include <bit>
#include <cstdint>

constexpr uint32_t SHIFT_PER_ROUND[64] = {
    7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
    5, 9,  14, 20, 5, 9,  14, 20, 5, 9,  14, 20, 5, 9,  14, 20,
    4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
    6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
};

constexpr uint32_t K[64] = {
    0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 0xf57c0faf, 0x4787c62a,
    0xa8304613, 0xfd469501, 0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
    0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821, 0xf61e2562, 0xc040b340,
    0x265e5a51, 0xe9b6c7aa, 0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
    0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed, 0xa9e3e905, 0xfcefa3f8,
    0x676f02d9, 0x8d2a4c8a, 0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
    0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70, 0x289b7ec6, 0xeaa127fa,
    0xd4ef3085, 0x04881d05, 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
    0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039, 0x655b59c3, 0x8f0ccc92,
    0xffeff47d, 0x85845dd1, 0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
    0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391,
};

constexpr uint32_t A0 = 0x67452301;
constexpr uint32_t B0 = 0xefcdab89;
constexpr uint32_t C0 = 0x98badcfe;
constexpr uint32_t D0 = 0x10325476;

void md5(uint32_t *message_pointer, uint32_t *result_pointer) {
  uint32_t a = A0;
  uint32_t b = B0;
  uint32_t c = C0;
  uint32_t d = D0;

  for (int i = 0; i < 64; i++) {
    uint32_t f = 0;
    uint32_t g = 0;

    if (i <= 15) {
      f = (b & c) | ((~b) & d);
      g = i;
    } else if (i <= 31) {
      f = (d & b) | ((~d) & c);
      g = (5 * i + 1) % 16;
    } else if (i <= 47) {
      f = b ^ c ^ d;
      g = (3 * i + 5) % 16;
    } else if (i <= 63) {
      f = c ^ (b | (~d));
      g = (7 * i) % 16;
    }

    uint32_t current_message_data = message_pointer[g];
    uint32_t rot = f + a + K[i] + current_message_data;

    a = d;
    d = c;
    c = b;
    b = b + std::rotl(rot, SHIFT_PER_ROUND[i]);
  }

  a = a + A0;
  b = b + B0;
  c = c + C0;
  d = d + D0;

  result_pointer[0] = a;
  result_pointer[1] = b;
  result_pointer[2] = c;
  result_pointer[3] = d;
}

// #include <cassert>
// int main() {
//   uint32_t input[16] = {128, 0, 0, 0, 0, 0, 0, 0,
//                         0,   0, 0, 0, 0, 0, 0, 0};
//   uint32_t output[4];
//   md5(input, output);
//   assert(output[0] == 0xd98c1dd4);
//   assert(output[1] == 0x04b2008f);
//   assert(output[2] == 0x980980e9);
//   assert(output[3] == 0x7e42f8ec);
// }