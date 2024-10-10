part of '../di.dart';

final repositoryModulesDi = GetIt.instance;

void _repositoryModulesInit() {
  remoteModulesDi.registerLazySingleton<AlimentRepositoryContract>(
    () => AlimentRepository(
      repositoryModulesDi(),
    ),
  );
  remoteModulesDi.registerLazySingleton<RecipeRepositoryContract>(
    () => RecipeRepository(
      repositoryModulesDi(),
    ),
  );
}
