import 'package:criptohub/domain/models/user.dart';
import 'package:criptohub/domain/repositories/user_repository.dart';
import 'package:criptohub/domain/usecases/get_user_with_email_and_password_use_case.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_with_email_and_password_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late GetUserWithEmailAndPasswordUseCase getUserWithEmailAndPasswordUseCase;
  late MockUserRepository mockUserRepository;
  late String email;
  late String password;

  late final Faker faker;
  late String newId;
  late String newName;
  late String newEmail;
  late String newPhone;

  provideDummy<User>(User(
    id: 'dummy_id',
    name: 'Usuário Dummy',
    email: 'dummy@exemplo.com',
    phone: '00000000000',
  ));

  setUpAll(() {
    faker = Faker();
    email = "tester@test.com.br";
    password = "tester";
  });

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserWithEmailAndPasswordUseCase = GetUserWithEmailAndPasswordUseCase(mockUserRepository);

    newId = faker.guid.guid();
    newName = faker.person.name();
    newEmail = faker.internet.email();
    newPhone = "+55 (88) 00000-0000";
  });

  group("Get User with email and password UseCase tests", () {
    test("Must return a user by passing their email and password.", () async {
      final User user = User(
        id: newId,
        name: newName,
        email: email,
        phone: newPhone,
      );

      when(mockUserRepository.getWithCredentials(email, password))
          .thenAnswer((_) async => user);

      final User result = await getUserWithEmailAndPasswordUseCase.call(email, password);

      expect(result.email, equals(email));

      verify(mockUserRepository.getWithCredentials(email, password)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}