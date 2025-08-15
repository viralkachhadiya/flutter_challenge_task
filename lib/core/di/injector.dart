import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/items/data/api/api_client.dart';
import '../../features/items/data/repositories/item_repository_impl.dart';
import '../../features/items/domain/repositories/item_repository.dart';
import '../../features/items/presentation/bloc/item_bloc.dart';

final locator = GetIt.instance;

Future<void> configureDependencies() async {
  // Dio
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ));
    return dio;
  });

  // API Client
  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<Dio>()));

  // Repository
  locator.registerLazySingleton<ItemRepository>(
      () => ItemRepositoryImpl(locator<ApiClient>()));

  // Bloc
  locator.registerFactory(() => ItemBloc(repository: locator<ItemRepository>()));
}
