import 'package:get_it/get_it.dart';
import 'package:resto/core/network/api_service.dart';
import 'package:resto/core/network/dio_client.dart';
import 'package:resto/features/auth/data/repos/auth_repo.dart';
import 'package:resto/features/auth/presentation/manager/login/login_cubit.dart';

import '../../features/auth/presentation/manager/register/register_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<ApiService>(() => ApiService());

  sl.registerLazySingleton<AuthRepo>(() => AuthRepoimpl());
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
}
