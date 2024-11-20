import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';
import 'package:nutri_teca/core/database/database_handler.dart';
import 'package:nutri_teca/core/providers/local_provider.dart';
import 'package:nutri_teca/core/routes/app_routes.dart';
import 'package:nutri_teca/firebase_options.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_event.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutri_teca/core/di/di.dart' as app_di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final db = DatabaseHandler();
  app_di.initDi(dbInstance: db);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            title: 'NutriTeca',
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
