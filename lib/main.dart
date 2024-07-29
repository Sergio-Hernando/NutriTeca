import 'package:flutter/material.dart';
import 'package:food_macros/core/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_macros/core/di/di.dart' as app_di;

Future<void> main() async {
  final sp = await SharedPreferences.getInstance();
  app_di.initDi(instance: sp);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      title: 'FoodMacros',
    );
  }
}
