import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../feature/auth/data/repository/auth_repository.dart';
import '../cache/cache.dart';
import '../service/supabase_service.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  await _initSupabase();
  await _initHive();
  await initializeCache();
  _repositories();
}

Future<void> _initSupabase() async {
  await SupabaseService.init();
  sl.registerSingleton<SupabaseService>(SupabaseService());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox("user");
  await Hive.openBox<List<String>>("chat");
  // Hive.registerAdapter(ChatModalAdapter());
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      client: sl<SupabaseService>().client,
    ),
  );
}
