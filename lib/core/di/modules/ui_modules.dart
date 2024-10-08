part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  // StreamController para manejar eventos generales
  uiModulesDi.registerSingleton<StreamController<void>>(
    StreamController<void>.broadcast(),
    instanceName: 'alimentEventController',
    dispose: (controller) => controller.close(),
  );

  // StreamController para manejar notificaciones sobre nuevas recetas
  uiModulesDi.registerSingleton<StreamController<void>>(
    StreamController<void>.broadcast(),
    instanceName: 'recipeNotificationController', // Nombre único
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
      alimentAddedController:
          uiModulesDi(instanceName: 'alimentEventController'),
    ),
  );
  uiModulesDi.registerFactory(
    () => SearchBloc(
      repositoryContract: uiModulesDi(),
      alimentAddedController:
          uiModulesDi(instanceName: 'alimentEventController'),
    ),
  );
  uiModulesDi.registerFactory(
    () => AlimentDetailBloc(
      repositoryContract: uiModulesDi(),
      alimentController: uiModulesDi(instanceName: 'alimentEventController'),
    ),
  );
  uiModulesDi.registerFactory(
    () => RecipeBloc(
      repositoryContract: uiModulesDi(),
      recipeNotificationController:
          uiModulesDi(instanceName: 'recipeNotificationController'),
    ),
  );
  uiModulesDi.registerFactory(
    () => AddRecipeBloc(
      repositoryContract: uiModulesDi(),
      alimentRepositoryContract: uiModulesDi(),
      recipeNotificationController:
          uiModulesDi(instanceName: 'recipeNotificationController'),
    ),
  );
}
