part of '../di.dart';

final repositoryModulesDi = GetIt.instance;

void _repositoryModulesInit() {
  repositoryModulesDi.registerLazySingleton<AlimentRepositoryContract>(
    () => AlimentRepository(
      repositoryModulesDi(),
    ),
  );
  repositoryModulesDi.registerLazySingleton<RecipeRepositoryContract>(
    () => RecipeRepository(
      repositoryModulesDi(),
    ),
  );
}
