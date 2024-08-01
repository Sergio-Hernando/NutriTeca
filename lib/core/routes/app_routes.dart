import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/presentation/screens/add_product/add_product_screen.dart';
import 'package:food_macros/presentation/screens/home/home_screen.dart';
import 'package:food_macros/presentation/screens/search/search_screen.dart';
import 'package:food_macros/presentation/screens/splash/splash_controller.dart';
import 'package:food_macros/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellSearchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final GlobalKey<NavigatorState> _shellAddProductNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAddProduct');
final GlobalKey<NavigatorState> _shellRecipesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRecipes');

GoRouter appRoutes = GoRouter(
    initialLocation: AppRoutesPath.main,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
          path: AppRoutesPath.main,
          builder: (context, state) => const SplashController(),
          routes: [
            /// MainWrapper
            StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) {
                return ScaffoldWithBottomNav(
                  navigationShell: navigationShell,
                );
              },
              branches: <StatefulShellBranch>[
                /// Brach Home
                StatefulShellBranch(
                  navigatorKey: _shellHomeNavigatorKey,
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'home',
                      name: "Home",
                      builder: (BuildContext context, GoRouterState state) =>
                          const HomeScreen(),
                      /* routes: [
                  GoRoute(
                    path: 'subHome',
                    name: 'subHome',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const SubHomeView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ], */
                    ),
                  ],
                ),

                /// Brach Setting
                StatefulShellBranch(
                  navigatorKey: _shellSearchNavigatorKey,
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'search',
                      name: "Settings",
                      builder: (BuildContext context, GoRouterState state) =>
                          const SearchScreen(),
                      /* routes: [
                  GoRoute(
                    path: "subSetting",
                    name: "subSetting",
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SubSettingsView(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                ], */
                    ),
                  ],
                ),

                /// Brach Add Product
                StatefulShellBranch(
                  navigatorKey: _shellAddProductNavigatorKey,
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'addProduct',
                      name: "Add Product",
                      builder: (BuildContext context, GoRouterState state) =>
                          const AddProductScreen(),
                      /* routes: [
                  GoRoute(
                    path: "subSetting",
                    name: "subSetting",
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SubSettingsView(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                ], */
                    ),
                  ],
                ),

                /// Brach Add Product
                /* StatefulShellBranch(
            navigatorKey: _shellRecipesNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutesPath.recipes,
                name: "recipes",
                builder: (BuildContext context, GoRouterState state) =>
                    const RecipesScreen(),
                /* routes: [
                  GoRoute(
                    path: "subSetting",
                    name: "subSetting",
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SubSettingsView(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                ], */
              ),
            ],
          ), */
              ],
            ),
          ])
    ]);
