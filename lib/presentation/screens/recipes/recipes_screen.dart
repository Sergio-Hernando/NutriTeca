import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_state.dart';
import 'package:food_macros/presentation/screens/recipes/widgets/custom_card.dart';
import 'package:food_macros/presentation/screens/recipes/widgets/custom_search_bar.dart';
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
            return const Center(child: CircularProgressIndicator());
          }
          if (state.screenStatus.isError()) {
            return const Center(child: Text('Error al cargar recetas'));
          } else {
            if (state.recipes.isEmpty) {
              return const Center(child: Text('No hay recetas disponibles'));
            }

            return Column(
              children: [
                RecipeSearchBar(
                  allItems: state.recipes,
                  onResults: (p0) {
                    context
                        .read<RecipeBloc>()
                        .add(RecipeEvent.updateSearch(p0));
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: state.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = state.recipes[index];
                        return CustomCard(recipe: recipe);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
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
