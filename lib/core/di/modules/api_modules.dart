part of '../di.dart';

final apiModulesDi = GetIt.instance;

void _apiModulesInit() {
  apiModulesDi.registerLazySingleton(() {
    var dioClient = DioClient();

    return dioClient.getDio();
  });

  /* apiModulesDi.registerLazySingleton(
    () => HomeApi(
      apiModulesDi(),
      baseUrl: AppUrls.baseUrl),
  ); */
}
