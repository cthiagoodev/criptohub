import 'package:criptohub/domain/utils/uuid_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UuidGenerator', () {
    test('Must return a UUID in the correct V4 format', () {
      final String uuid = UuidGenerator.generateV4();

      expect(uuid.length, 36);

      final RegExp uuidV4Regex = RegExp(
          r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$');

      expect(uuid, matches(uuidV4Regex));
      expect(uuid[14], '4');

      final String variantChar = uuid[19];
      expect(['8', '9', 'a', 'b'].contains(variantChar.toLowerCase()), isTrue);
    });

    test('Must generate different UUIDs on consecutive calls', () {
      final String uuid1 = UuidGenerator.generateV4();
      final String uuid2 = UuidGenerator.generateV4();
      expect(uuid1, isNot(uuid2));
    });

    test('Should generate a large number of UUIDs without obvious repetition', () {
      const int numUUIDs = 1000;
      final Set<String> uniqueUUIDs = <String>{};

      for (int i = 0; i < numUUIDs; i++) {
        uniqueUUIDs.add(UuidGenerator.generateV4());
      }

      expect(uniqueUUIDs.length, numUUIDs);
    });
  });
}