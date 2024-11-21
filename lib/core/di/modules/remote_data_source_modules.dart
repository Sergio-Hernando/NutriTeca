part of '../di.dart';

final remoteModulesDi = GetIt.instance;

void _remoteDataSourceModulesInit(
    {required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleAuth,
    required SharedPreferences sharedPreferences}) {
  remoteModulesDi.registerSingleton<FirebaseAuth>(firebaseAuth);

  /* remoteModulesDi.registerLazySingleton<AlimentDataSourceContract>(
      () => AlimentRemoteDataSource(remoteModulesDi())); */

  remoteModulesDi.registerLazySingleton<AuthDataSourceContract>(
    () => AuthRemoteDataSource(
        remoteModulesDi<FirebaseAuth>(), sharedPreferences, googleAuth),
  );
}
