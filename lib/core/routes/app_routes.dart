import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_macros/core/di/di.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_bloc.dart';
import 'package:food_macros/presentation/screens/home/home_screen.dart';
import 'package:food_macros/presentation/screens/splash/splash_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');

GoRouter appRoutes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
          path: AppRoutesPath.main,
          builder: (context, state) => const SplashController(),
          routes: [
            ShellRoute(
                navigatorKey: _homeNavigatorKey,
                builder: (context, state, child) {
                  return BlocProvider(
                    create: (context) =>
                        HomeBloc(repositoryContract: uiModulesDi()),
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'home',
                    builder: (context, state) => const HomeScreen(),
                  ),
                  /* GoRoute(
                        path: 'search',
                        builder: (context, state) => const SearchScreen(),
                      ),
                      GoRoute(
                        path: 'addProduct',
                        builder: (context, state) => const AddProductScreen(),
                      ),
                      GoRoute(
                        path: 'recipes',
                        builder: (context, state) => const RecipesScreen(),
                      ), */
                ])
          ])
    ]);
