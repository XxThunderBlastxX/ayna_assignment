import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../feature/auth/data/repository/auth_repository.dart';
import '../local_storage/user/user_hive.dart';
import '../service/supabase_service.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  await _initSupabase();
  await _initHive();
  _repositories();
  _hiveObjects();
}

Future<void> _initSupabase() async {
  await SupabaseService.init();
  sl.registerSingleton<SupabaseService>(SupabaseService());
}

Future<void> _initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.openBox("user");
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      client: sl<SupabaseService>().client,
    ),
  );
}

void _hiveObjects() {
  sl.registerLazySingleton<UserHive>(() => UserHive());
}
