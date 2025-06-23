import 'dart:developer';

import 'package:criptohub/data/adapters/firebase_core_adapter.dart';
import 'package:criptohub/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

final class FirebaseService {
  final FirebaseCoreAdapter _adapter;

  FirebaseService(this._adapter);

  FirebaseApp get app => _adapter.app();

  Future<FirebaseService> initialize() async {
    try {
      final FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;
      await _adapter.initializeApp(options: options);
      return this;
    } on FirebaseException catch(error, stackTrace) {
      final bool hasInitialized = ["core/duplicate-app", "[core/duplicate-app]"]
          .contains(error.code);

      log("Firebase error", error: error, stackTrace: stackTrace);

      if(!hasInitialized) {
        rethrow;
      }

      return this;
    }
  }
}