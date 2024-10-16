import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:go_router/go_router.dart';

class CustomCard extends StatelessWidget {
  final RecipeEntity recipe;

  const CustomCard({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    context.go(AppRoutesPath.recipeDetail, extra: recipe.id),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      recipe.instructions ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  {}, //context.go(AppRoutesPath.recipeDetail, extra: recipe),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
