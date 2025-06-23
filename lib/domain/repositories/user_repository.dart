import 'package:criptohub/domain/models/user.dart';

abstract interface class UserRepository {
  Future<User> getWithCredentials(String email, String password);
  Future<User> create(User user);
  Future<User> delete(String userId);
}