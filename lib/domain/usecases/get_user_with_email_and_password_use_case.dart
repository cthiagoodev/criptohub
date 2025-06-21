import 'package:criptohub/domain/models/user.dart';
import 'package:criptohub/domain/repositories/user_repository.dart';

final class GetUserWithEmailAndPasswordUseCase {
  final UserRepository _repository;

  const GetUserWithEmailAndPasswordUseCase(this._repository);

  Future<User> call(String email, String password) async {
    return await _repository.get(email, password);
  }
}