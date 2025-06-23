import 'package:criptohub/data/adapters/firebase_core_adapter.dart';
import 'package:criptohub/data/adapters/firebase_core_adapter_imp.dart';
import 'package:criptohub/data/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

GetIt Injection = GetIt.instance;

Future<void> setupInjection() async {
  Injection.registerLazySingleton<FirebaseCoreAdapter>(() => FirebaseCoreAdapterImp());
  Injection.registerSingletonAsync(() => FirebaseService(Injection()).initialize());
}