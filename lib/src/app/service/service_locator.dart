import 'package:get_it/get_it.dart';

import '../../feature/auth/data/repository/auth_repository.dart';
import '../cache/cache.dart';
import 'supabase_service.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  await _initSupabase();
  await initializeCache();
  _repositories();
}

Future<void> _initSupabase() async {
  await SupabaseService.init();
  sl.registerSingleton<SupabaseService>(SupabaseService());
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      client: sl<SupabaseService>().client,
    ),
  );
}
