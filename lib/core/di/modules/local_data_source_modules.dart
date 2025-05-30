part of '../di.dart';

final localModulesDi = GetIt.instance;

void _localDataSourceModulesInit({required DatabaseHandler dbInstance}) {
  localModulesDi.registerLazySingleton<AlimentDataSourceContract>(
    () => AlimentDataSource(dbHandler: dbInstance),
  );
  localModulesDi.registerLazySingleton<RecipeDataSourceContract>(
    () => RecipeDataSource(dbHandler: dbInstance),
  );
  localModulesDi.registerLazySingleton<MonthlySpentDataSourceContract>(
    () => MonthlySpentDataSource(dbHandler: dbInstance),
  );
  localModulesDi.registerLazySingleton<AdditivesDataSourceContract>(
    () => AdditiveDataSource(dbHandler: dbInstance),
  );
}
