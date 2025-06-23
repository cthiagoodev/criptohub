import 'package:criptohub/data/adapters/firebase_core_adapter.dart';
import 'package:criptohub/data/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './firebase_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseCoreAdapter>(),
  MockSpec<FirebaseApp>(),
  MockSpec<FirebaseOptions>(),
])
void main() {
  late MockFirebaseCoreAdapter mockAdapter;
  late MockFirebaseApp mockFirebaseApp;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockAdapter = MockFirebaseCoreAdapter();
    mockFirebaseApp = MockFirebaseApp();

    when(mockAdapter.app()).thenReturn(mockFirebaseApp);
    when(mockFirebaseApp.options).thenReturn(MockFirebaseOptions());
    when(mockFirebaseApp.name).thenReturn("DEFAULT");
  });

  group("FirebaseService Test", () {
    test("Must initialize FirebaseApp successfully", () async {
      when(mockAdapter.initializeApp(options: anyNamed('options')))
          .thenAnswer((_) async => mockFirebaseApp);

      final FirebaseService firebaseService = await FirebaseService(mockAdapter).initialize();

      expect(firebaseService.app, equals(mockFirebaseApp));
      expect(firebaseService.app.options, isA<FirebaseOptions>());
      expect(firebaseService.app.name, "DEFAULT");

      verify(mockAdapter.initializeApp(options: anyNamed('options'))).called(1);
      verify(mockAdapter.app()).called(greaterThanOrEqualTo(1));
      verifyNoMoreInteractions(mockAdapter);
    });

    test("Must handle duplicate app error gracefully", () async {
      final FirebaseException duplicateAppException = FirebaseException(
        code: 'core/duplicate-app',
        message: 'A Firebase App named "[DEFAULT]" already exists.',
        plugin: 'core',
      );

      when(mockAdapter.initializeApp(options: anyNamed('options')))
          .thenThrow(duplicateAppException);

      final FirebaseService firebaseService = await FirebaseService(mockAdapter).initialize();

      expect(firebaseService.app, equals(mockFirebaseApp));
      expect(firebaseService.app.options, isA<FirebaseOptions>());
      expect(firebaseService.app.name, "DEFAULT");

      verify(mockAdapter.initializeApp(options: anyNamed('options'))).called(1);
      verify(mockAdapter.app()).called(greaterThanOrEqualTo(1));
      verifyNoMoreInteractions(mockAdapter);
    });

    test("Must rethrow other FirebaseExceptions", () async {
      final FirebaseException otherException = FirebaseException(
        code: 'permission-denied',
        message: 'Permission denied for this operation.',
        plugin: 'Firestore',
      );

      when(mockAdapter.initializeApp(options: anyNamed('options')))
          .thenThrow(otherException);

      expect(() async => await FirebaseService(mockAdapter).initialize(),
        throwsA(isA<FirebaseException>()),
      );

      verify(mockAdapter.initializeApp(options: anyNamed('options'))).called(1);
      verifyNoMoreInteractions(mockAdapter);
    });
  });
}