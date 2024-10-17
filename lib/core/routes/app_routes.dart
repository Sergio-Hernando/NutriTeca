import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/di/di.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/add_aliment_screen.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/add_recipe_screen.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/aliment_detail_screen.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_bloc.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/filters/filters_screen.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_bloc.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_event.dart';
import 'package:food_macros/presentation/screens/home/home_screen.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/recipe_detail_screen.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipes/recipes_screen.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/aliments_screen.dart';
import 'package:food_macros/presentation/screens/splash/splash_controller.dart';
import 'package:food_macros/presentation/shared/aliment_action.dart';
import 'package:food_macros/presentation/screens/base_screen/base_screen.dart';
import 'package:food_macros/presentation/shared/recipe_action.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellHomeBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHomeBloc');
final GlobalKey<NavigatorState> _shellAlimentsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAliments');
final GlobalKey<NavigatorState> _shellAlimentsBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAlimentsBloc');
final GlobalKey<NavigatorState> _shellAddAlimentNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAddAliment');
final GlobalKey<NavigatorState> _shellAddAlimentBlocNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAddAlimentBloc');
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
                /// Brach Aliments
                StatefulShellBranch(
                  navigatorKey: _shellAlimentsNavigatorKey,
                  routes: <RouteBase>[
                    ShellRoute(
                      navigatorKey: _shellAlimentsBlocNavigatorKey,
                      builder: (context, state, child) {
                        return BlocProvider(
                          create: (context) => AlimentsBloc(
                            repositoryContract: uiModulesDi(),
                            alimentAddedController:
                                uiModulesDi<StreamController<AlimentAction>>(
                                    instanceName: 'alimentEventController'),
                          )..add(
                              const AlimentsEvent.fetchAllAlimentsList(),
                            ),
                          child: child,
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'aliments',
                          name: "Aliments",
                          builder: (context, state) => const AlimentsScreen(),
                          routes: [
                            GoRoute(
                              path: 'addAliment',
                              name: "Add Aliment",
                              parentNavigatorKey: _rootNavigatorKey,
                              builder: (context, state) {
                                return BlocProvider(
                                  create: (context) => AddAlimentBloc(
                                    repositoryContract: uiModulesDi(),
                                    alimentAddedController: uiModulesDi<
                                            StreamController<AlimentAction>>(
                                        instanceName: 'alimentEventController'),
                                  ),
                                  child: const AddAlimentScreen(),
                                );
                              },
                            ),
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
                                          StreamController<RecipeAction>>(
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
                                                StreamController<RecipeAction>>(
                                            instanceName:
                                                'recipeNotificationController'),
                                      ),
                                      child: const AddRecipeScreen(),
                                    );
                                  },
                                ),
                                GoRoute(
                                  path: "detail",
                                  name: "Recipe Detail",
                                  parentNavigatorKey: _rootNavigatorKey,
                                  builder: (context, state) {
                                    final recipeId = state.extra as int;
                                    return BlocProvider(
                                      create: (context) => RecipeDetailBloc(
                                        repository: uiModulesDi(),
                                        alimentRepository: uiModulesDi(),
                                        recipeController: uiModulesDi<
                                                StreamController<RecipeAction>>(
                                            instanceName:
                                                'recipeNotificationController'),
                                      )
                                        ..add(
                                          RecipeDetailEvent.getRecipe(recipeId),
                                        )
                                        ..add(const RecipeDetailEvent
                                            .getAliments()),
                                      child: const RecipeDetailScreen(),
                                    );
                                  },
                                ),
                              ]),
                        ])
                  ],
                ),
              ],
            ),
          ])
    ]);
