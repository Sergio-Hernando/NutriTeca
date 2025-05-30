import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipes/bloc/recipe_bloc.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipes/bloc/recipe_event.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipes/bloc/recipe_state.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipes/widgets/recipe_list.dart';
import 'package:nutri_teca/presentation/widgets/generic_search_bar.dart';

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
            return Center(
              child: Text(context.localizations.recipesError),
            );
          }

          final foundRecipes = state.recipes;

          return Column(
            children: [
              GenericSearchBar<RecipeEntity>(
                allItems: foundRecipes,
                getItemName: (RecipeEntity item) => item.name ?? '',
                onResults: (results, enteredKeyword) {
                  context.read<RecipeBloc>().add(
                        RecipeEvent.updateSearch(results, enteredKeyword),
                      );
                },
                hintText: context.localizations.searchRecipe,
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
    );
  }
}
