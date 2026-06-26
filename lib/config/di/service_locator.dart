import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/app_theme_cubit.dart';
import '../constants/api_constants.dart';

final GetIt sl = GetIt.instance;

/// Initialize all app dependencies.
Future<void> initServiceLocator() async {
  // External services
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<Logger>(() => Logger());

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    ),
  );

  // Use cases
  // sl.registerLazySingleton<GetProductsUseCase>(
  //   () => GetProductsUseCase(sl()),
  // );
}
