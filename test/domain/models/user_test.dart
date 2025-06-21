import 'package:criptohub/domain/models/user.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final Faker faker;
  late String id;
  late String name;
  late String email;
  late String phone;

  setUpAll(() {
    faker = Faker();
  });

  setUp(() {
    id = faker.guid.guid();
    name = faker.person.name();
    email = faker.internet.email();
    phone = "+55 (88) 99999-9999";
  });

  group("User Model Test", () {
    test("Must return a user instance", () {
      final User user = User(
        id: id,
        name: name,
        email: email,
        phone: phone,
      );

      expect(user, isA<User>());
      expect(user.id, id);
      expect(user.name, name);
      expect(user.email, email);
      expect(user.email, contains('@'));
      expect(user.phone, phone);
      expect(user.phone, matches(RegExp(r"^\+?\d{2}\s?\(\d{2}\)\s?\d{4,5}-?\d{4}$")));
    });

    test("Must validate if the id is empty and return an error", () {
      expect(() => User(
        id: "",
        name: name,
        email: email,
        phone: phone,
      ), throwsArgumentError);
    });

    test("Must validate if the name is empty and return an error", () {
      expect(() => User(
        id: id,
        name: "",
        email: email,
        phone: phone,
      ), throwsArgumentError);
    });

    test("Must validate if the email is empty and return an error", () {
      expect(() => User(
        id: id,
        name: name,
        email: "",
        phone: phone,
      ), throwsArgumentError);
    });

    test("Must validate if the email not contains '@' and return an error", () {
      expect(() => User(
        id: id,
        name: name,
        email: email.replaceAll("@", ""),
        phone: phone,
      ), throwsFormatException);
    });

    test("Must validate if the phone is empty and return an error", () {
      expect(() => User(
        id: id,
        name: name,
        email: email,
        phone: "",
      ), throwsArgumentError);
    });

    test("Must create a new user keeping the same id", () {
      final User user = User(
        id: id,
        name: name,
        email: email,
        phone: phone,
      );

      final String otherName = faker.person.name();
      final String otherEmail = faker.internet.email();
      final String otherPhone = "+55 (88) 00000-0000";

      final User newUser = user.copyWith(
        name: otherName,
        email: otherEmail,
        phone: otherPhone,
      );

      expect(user.id, equals(newUser.id));
      expect(user.name, isNot(equals(newUser.name)));
      expect(user.email, isNot(equals(newUser.email)));
      expect(user.phone, isNot(equals(newUser.phone)));
    });

    test("Must create a new user with automatic id generation", () {
      final User user = User.autoUuid(
        name: name,
        email: email,
        phone: phone,
      );

      expect(user.id, isNotEmpty);
    });
  });
}