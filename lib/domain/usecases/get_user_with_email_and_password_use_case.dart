import 'package:criptohub/domain/exceptions/validation_exceptions.dart';
import 'package:criptohub/domain/models/result.dart';
import 'package:criptohub/domain/models/user.dart';
import 'package:criptohub/domain/repositories/user_repository.dart';

final class GetUserWithEmailAndPasswordUseCase {
  final UserRepository _repository;

  const GetUserWithEmailAndPasswordUseCase(this._repository);

  Future<Result<User>> call(String email, String password) async {
    try {
      final formattedEmail = email.trim();
      final formattedPassword = password.trim();

      if(formattedEmail.isEmpty) throw AttributeEmptyException("Email cannot be empty");
      if(!formattedEmail.contains("@")) throw AttributeUnformattedException("Invalid email format");
      if(formattedPassword.isEmpty) throw AttributeEmptyException("Password cannot be empty");

      final User user = await _repository.getWithCredentials(formattedEmail, formattedPassword);
      return Result.success(user);
    } on Exception catch(error) {
      return Result.error(
        error: error,
        errorMessage: error.toString(),
      );
    } on Error catch(error) {
      return Result.error(
        error: Exception("Internal error occurred: $error"),
        errorMessage: error.toString(),
      );
    }
  }
}