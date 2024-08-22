part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  uiModulesDi
      .registerFactory(() => HomeBloc(repositoryContract: uiModulesDi()));
  uiModulesDi.registerFactory(() => SplashBloc());
  uiModulesDi
      .registerFactory(() => AddProductBloc(repositoryContract: uiModulesDi()));
}
