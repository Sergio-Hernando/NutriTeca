import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/di/di.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/screens/add_product/add_product_screen.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_bloc.dart';
import 'package:food_macros/presentation/screens/add_recipe/add_recipe_screen.dart';
import 'package:food_macros/presentation/screens/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:food_macros/presentation/screens/aliment_detail/aliment_detail_screen.dart';
import 'package:food_macros/presentation/screens/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_bloc.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_event.dart';
import 'package:food_macros/presentation/screens/filters/filters_screen.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_bloc.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_event.dart';
import 'package:food_macros/presentation/screens/home/home_screen.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/recipes_screen.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_bloc.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_event.dart';
import 'package:food_macros/presentation/screens/search/search_screen.dart';
import 'package:food_macros/presentation/screens/splash/splash_controller.dart';
import 'package:food_macros/presentation/shared/aliment_action.dart';
import 'package:food_macros/presentation/screens/base_screen/base_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellHomeBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHomeBloc');
final GlobalKey<NavigatorState> _shellSearchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final GlobalKey<NavigatorState> _shellSearchBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSearchBloc');
final GlobalKey<NavigatorState> _shellAddProductNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAddProduct');
final GlobalKey<NavigatorState> _shellAddProductBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAddProductBloc');
final GlobalKey<NavigatorState> _shellRecipesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRecipes');
final GlobalKey<NavigatorState> _shellRecipesBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellRecipesBloc');

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
                final baseScreenBloc = BaseScreenBloc(
                  alimentRepositoryContract: uiModulesDi(),
                  monthlySpentRepository: uiModulesDi(),
                  monthlySpentNotificationController:
                      uiModulesDi<StreamController<MonthlySpentEntity>>(
                          instanceName: 'monthlySpentNotificationController'),
                );

                baseScreenBloc.add(const BaseScreenEvent.getAllAlimentsList());

                return BlocProvider(
                  create: (context) => baseScreenBloc,
                  child: BaseScreen(
                    navigationShell: navigationShell,
                  ),
                );
              },
              branches: <StatefulShellBranch>[
                /// Brach Home
                StatefulShellBranch(
                  navigatorKey: _shellHomeNavigatorKey,
                  routes: <RouteBase>[
                    ShellRoute(
                        navigatorKey: _shellHomeBlocNavigatorKey,
                        builder: (context, state, child) {
                          return BlocProvider(
                            create: (context) => HomeBloc(
                                monthlySpentRepository: uiModulesDi(),
                                monthlySpentController: uiModulesDi(
                                    instanceName:
                                        'monthlySpentNotificationController'),
                                additiveRepositoryContract: uiModulesDi())
                              ..add(const HomeEvent.getAllMonthlySpent())
                              ..add(const HomeEvent.getAdditives()),
                            child: child,
                          );
                        },
                        routes: [
                          GoRoute(
                            path: 'home',
                            name: "Home",
                            builder: (context, state) => const HomeScreen(),
                          ),
                        ])
                  ],
                ),

                /// Brach Search
                StatefulShellBranch(
                  navigatorKey: _shellSearchNavigatorKey,
                  routes: <RouteBase>[
                    ShellRoute(
                      navigatorKey: _shellSearchBlocNavigatorKey,
                      builder: (context, state, child) {
                        return BlocProvider(
                          create: (context) => SearchBloc(
                            repositoryContract: uiModulesDi(),
                            alimentAddedController:
                                uiModulesDi<StreamController<AlimentAction>>(
                                    instanceName: 'alimentEventController'),
                          )..add(
                              const SearchEvent.fetchAllAlimentsList(),
                            ),
                          child: child,
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'search',
                          name: "Search",
                          builder: (context, state) => const SearchScreen(),
                          routes: [
                            GoRoute(
                              path: "filters",
                              name: "Filters",
                              parentNavigatorKey: _rootNavigatorKey,
                              builder: (context, state) => const FilterScreen(),
                            ),
                            GoRoute(
                              path: "detail",
                              name: "Aliment Detail",
                              parentNavigatorKey: _rootNavigatorKey,
                              builder: (context, state) {
                                final aliment = state.extra as AlimentEntity;
                                return BlocProvider(
                                  create: (context) => AlimentDetailBloc(
                                    repositoryContract: uiModulesDi(),
                                    alimentController: uiModulesDi<
                                            StreamController<AlimentAction>>(
                                        instanceName: 'alimentEventController'),
                                  ),
                                  child: AlimentDetailScreen(aliment: aliment),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Brach Add Product
                StatefulShellBranch(
                  navigatorKey: _shellAddProductNavigatorKey,
                  routes: <RouteBase>[
                    ShellRoute(
                        navigatorKey: _shellAddProductBlocNavigatorKey,
                        builder: (context, state, child) {
                          return BlocProvider(
                              create: (context) => AddProductBloc(
                                    repositoryContract: uiModulesDi(),
                                    alimentAddedController: uiModulesDi<
                                            StreamController<AlimentAction>>(
                                        instanceName: 'alimentEventController'),
                                  ),
                              child: child);
                        },
                        routes: [
                          GoRoute(
                            path: 'addProduct',
                            name: "Add Product",
                            builder: (context, state) =>
                                const AddProductScreen(),
                          ),
                        ])
                  ],
                ),

                /// Brach Recipes
                StatefulShellBranch(
                  navigatorKey: _shellRecipesNavigatorKey,
                  routes: <RouteBase>[
                    ShellRoute(
                        navigatorKey: _shellRecipesBlocNavigatorKey,
                        builder: (context, state, child) {
                          return BlocProvider(
                              create: (context) => RecipeBloc(
                                  repositoryContract: uiModulesDi(),
                                  recipeNotificationController: uiModulesDi<
                                          StreamController<RecipeEntity>>(
                                      instanceName:
                                          'recipeNotificationController'))
                                ..add(
                                  const RecipeEvent.getRecipes(),
                                ),
                              child: child);
                        },
                        routes: [
                          GoRoute(
                              path: 'recipes',
                              name: "Recipes",
                              builder: (context, state) => const RecipeScreen(),
                              routes: [
                                GoRoute(
                                  path: 'addRecipe',
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    return BlocProvider(
                                      create: (context) => AddRecipeBloc(
                                        repositoryContract: uiModulesDi(),
                                        alimentRepositoryContract:
                                            uiModulesDi(),
                                        recipeNotificationController: uiModulesDi<
                                                StreamController<RecipeEntity>>(
                                            instanceName:
                                                'recipeNotificationController'),
                                      ),
                                      child: const AddRecipeScreen(),
                                    );
                                  },
                                )
                              ]),
                        ])
                  ],
                ),
              ],
            ),
          ])
    ]);
