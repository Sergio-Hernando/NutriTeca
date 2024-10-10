import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_state.dart';
import 'package:food_macros/presentation/screens/recipes/widgets/custom_search_bar.dart';
import 'package:food_macros/presentation/screens/recipes/widgets/recipe_list.dart';
import 'package:go_router/go_router.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.screenStatus.isLoading()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.screenStatus.isError()) {
            return const Center(
              child: Text('Error al cargar recetas'),
            );
          }

          final foundRecipes = state.recipes;

          return Column(
            children: [
              RecipeSearchBar(
                allItems: foundRecipes,
                onResults: (p0) {
                  context.read<RecipeBloc>().add(
                        RecipeEvent.updateSearch(p0),
                      );
                },
              ),
              Expanded(
                child: RecipesList(
                  recipes: foundRecipes,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => context.push(AppRoutesPath.addRecipe),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
