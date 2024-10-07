part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  uiModulesDi.registerSingleton<StreamController<void>>(
    StreamController<void>.broadcast(),
    dispose: (controller) => controller.close(),
  );
  uiModulesDi.registerFactory(
    () => HomeBloc(
      repositoryContract: uiModulesDi(),
    ),
  );
  uiModulesDi.registerFactory(
    () => SplashBloc(),
  );
  uiModulesDi.registerFactory(
    () => AddProductBloc(
      repositoryContract: uiModulesDi(),
      alimentAddedController: uiModulesDi(),
    ),
  );
  uiModulesDi.registerFactory(
    () => SearchBloc(
      repositoryContract: uiModulesDi(),
      alimentAddedController: uiModulesDi(),
    ),
  );
  uiModulesDi.registerFactory(
    () => AlimentDetailBloc(
      repositoryContract: uiModulesDi(),
      alimentController: uiModulesDi(),
    ),
  );
  uiModulesDi.registerFactory(
    () => RecipeBloc(
      repositoryContract: uiModulesDi(),
      alimentRepositoryContract: uiModulesDi(),
    ),
  );
}
