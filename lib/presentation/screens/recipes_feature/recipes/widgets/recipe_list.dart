import 'package:flutter/material.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipes/widgets/recipe_card.dart';

class RecipesList extends StatelessWidget {
  final List<RecipeEntity> recipes;

  const RecipesList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return recipes.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) => RecipeCard(
                recipe: recipes[index],
              ),
            ),
          )
        : Center(
            child: Text(
              context.localizations.noResults,
              style: const TextStyle(color: Colors.grey),
            ),
          );
  }
}
