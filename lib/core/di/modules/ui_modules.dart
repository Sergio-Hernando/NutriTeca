part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  // StreamController para manejar eventos generales
  uiModulesDi.registerSingleton<StreamController<AlimentAction>>(
    StreamController<AlimentAction>.broadcast(),
    instanceName: 'alimentEventController',
    dispose: (controller) => controller.close(),
  );

  // StreamController para manejar notificaciones sobre nuevas recetas
  uiModulesDi.registerSingleton<StreamController<RecipeAction>>(
    StreamController<RecipeAction>.broadcast(),
    instanceName: 'recipeNotificationController',
    dispose: (controller) => controller.close(),
  );

  // StreamController para manejar notificaciones sobre gastos mensuales
  uiModulesDi.registerSingleton<StreamController<MonthlySpentEntity>>(
    StreamController<MonthlySpentEntity>.broadcast(),
    instanceName: 'monthlySpentNotificationController',
    dispose: (controller) => controller.close(),
  );

  uiModulesDi.registerFactory(
    () => SplashBloc(splashRepositoryContract: uiModulesDi()),
  );

  uiModulesDi.registerFactory(
    () => LoginBloc(authRepository: uiModulesDi()),
  );
  uiModulesDi.registerFactory(
    () => RegisterBloc(authRepository: uiModulesDi()),
  );

  uiModulesDi.registerFactory(
    () => BaseScreenBloc(
      alimentRepositoryContract: uiModulesDi(),
      monthlySpentRepository: uiModulesDi(),
      monthlySpentNotificationController:
          uiModulesDi(instanceName: 'monthlySpentNotificationController'),
    ),
  );

  uiModulesDi.registerFactory(
    () => HomeBloc(
        monthlySpentRepository: uiModulesDi(),
        monthlySpentController:
            uiModulesDi(instanceName: 'monthlySpentNotificationController'),
        additiveRepositoryContract: uiModulesDi()),
  );

  uiModulesDi.registerFactory(
    () => AlimentsBloc(
      repositoryContract: uiModulesDi(),
      alimentAddedController:
          uiModulesDi(instanceName: 'alimentEventController'),
    ),
  );

  uiModulesDi.registerFactory(
    () => AddAlimentBloc(
      repositoryContract: uiModulesDi(),
      alimentAddedController:
          uiModulesDi(instanceName: 'alimentEventController'),
    ),
  );
  uiModulesDi.registerFactory(
    () => AlimentDetailBloc(
      repositoryContract: uiModulesDi(),
      alimentController: uiModulesDi(instanceName: 'alimentEventController'),
      recipesRepository: uiModulesDi(),
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
    () => RecipeDetailBloc(
      repository: uiModulesDi(),
      alimentRepository: uiModulesDi(),
      recipeController:
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
