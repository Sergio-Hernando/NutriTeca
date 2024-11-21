part of '../di.dart';

final apiModulesDi = GetIt.instance;

void _apiModulesInit() {
  apiModulesDi.registerLazySingleton(() {
    var dioClient = DioClient();

    return dioClient.getDio();
  });

  apiModulesDi.registerLazySingleton(
    () => AlimentApi(apiModulesDi(), baseUrl: AppUrls.baseUrl),
  );
  apiModulesDi.registerLazySingleton(
    () => AdditivesApi(apiModulesDi(), baseUrl: AppUrls.baseUrl),
  );
  apiModulesDi.registerLazySingleton(
    () => MonthlySpentApi(apiModulesDi(), baseUrl: AppUrls.baseUrl),
  );
  apiModulesDi.registerLazySingleton(
    () => RecipeApi(apiModulesDi(), baseUrl: AppUrls.baseUrl),
  );
}
