import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/routes/app_routes.dart';
import 'package:food_macros/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:food_macros/presentation/screens/splash/bloc/splash_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_macros/core/di/di.dart' as app_di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  app_di.initDi(instance: sp);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashBloc()..add(const SplashEvent.unSplashInMilliseconds(2000)),
      child: MaterialApp.router(
        routerConfig: appRoutes,
        debugShowCheckedModeBanner: false,
        title: 'FoodMacros',
        theme: AppTheme.mainTheme,
      ),
    );
  }
}
