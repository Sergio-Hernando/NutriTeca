import 'package:flutter/material.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipes/widgets/custom_card.dart';

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
              itemBuilder: (context, index) => CustomCard(
                recipe: recipes[index],
              ),
            ),
          )
        : const Center(
            child: Text(
              'No results found',
              style: TextStyle(color: Colors.grey),
            ),
          );
  }
}
