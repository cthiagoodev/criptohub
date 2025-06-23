import 'package:criptohub/data/adapters/firebase_core_adapter.dart';
import 'package:firebase_core/firebase_core.dart';

final class FirebaseCoreAdapterImp extends FirebaseCoreAdapter {
  @override
  FirebaseApp app([String name = "DEFAULT"]) {
    return Firebase.app(name);
  }

  @override
  Future<FirebaseApp> initializeApp({required FirebaseOptions options}) async {
    return Firebase.initializeApp(options: options);
  }
}