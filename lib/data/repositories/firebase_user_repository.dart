import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:criptohub/domain/models/user.dart';
import 'package:criptohub/domain/repositories/user_repository.dart';

final class FirebaseUserRepository implements UserRepository {
  final fa.FirebaseAuth _auth;

  const FirebaseUserRepository(this._auth);

  @override
  Future<User> getWithCredentials(String email, String password) async {
    final fa.UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    throw UnimplementedError();
  }

  @override
  Future<User> create(User user) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<User> delete(String userId) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}