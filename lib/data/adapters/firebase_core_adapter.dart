import 'package:firebase_core/firebase_core.dart';

abstract class FirebaseCoreAdapter {
  Future<FirebaseApp> initializeApp({required FirebaseOptions options});
  FirebaseApp app([String name]);
}