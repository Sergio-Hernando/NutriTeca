part of '../di.dart';

final repositoryModulesDi = GetIt.instance;

void _repositoryModulesInit({required SharedPreferences sharedPreferences}) {
  repositoryModulesDi.registerLazySingleton<SplashRepositoryContract>(
    () => SplashRepository(
      sharedPreferences,
    ),
  );
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
  repositoryModulesDi.registerLazySingleton<MonthlySpentRepositoryContract>(
    () => MonthlySpentRepository(
      repositoryModulesDi(),
    ),
  );
  repositoryModulesDi.registerLazySingleton<AdditiveRepositoryContract>(
    () => AdditiveRepository(
      repositoryModulesDi(),
    ),
  );
  repositoryModulesDi.registerLazySingleton<AuthRepositoryContract>(
    () => AuthRepository(
      repositoryModulesDi(),
    ),
  );
}
