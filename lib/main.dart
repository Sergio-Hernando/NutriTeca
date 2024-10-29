import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/core/providers/local_provider.dart';
import 'package:food_macros/core/routes/app_routes.dart';
import 'package:food_macros/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:food_macros/presentation/screens/splash/bloc/splash_event.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_macros/core/di/di.dart' as app_di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = DatabaseHandler();
  app_di.initDi(dbInstance: db);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashBloc()..add(const SplashEvent.unSplashInMilliseconds(2000)),
      child: Consumer(
        builder: (context, value, child) {
          final localeProvider = LocaleProvider();
          return MaterialApp.router(
            routerConfig: appRoutes,
            debugShowCheckedModeBanner: false,
            title: 'FoodMacros',
            theme: AppTheme.mainTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: localeProvider.supportedLocales,
            locale: localeProvider.getLocale(),
          );
        },
      ),
    );
  }
}
