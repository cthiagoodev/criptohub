import 'dart:math';

class UuidGenerator {
  static final Random _random = Random();

  static String generateV4() {
    String get48BitRandomHex() {
      final int high24Bits = _random.nextInt(1 << 24);
      final int low24Bits = _random.nextInt(1 << 24);
      final int combined48Bits = (high24Bits << 24) | low24Bits;
      return combined48Bits.toRadixString(16).padLeft(12, '0');
    }

    final String part1 = _random.nextInt(0xFFFFFFFF).toRadixString(16).padLeft(8, '0');
    final String part2 = _random.nextInt(0xFFFF).toRadixString(16).padLeft(4, '0');
    final String part3 = '4${_random.nextInt(0xFFF).toRadixString(16).padLeft(3, '0')}';
    final String part4 = ((_random.nextInt(0x3FFF) | 0x8000) & 0xFFFF)
        .toRadixString(16)
        .padLeft(4, '0');
    final String part5 = get48BitRandomHex();

    return '$part1-$part2-$part3-$part4-$part5';
  }
}