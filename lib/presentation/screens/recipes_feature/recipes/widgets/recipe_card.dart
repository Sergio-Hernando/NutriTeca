import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/routes/app_paths.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_teca/presentation/widgets/ad_widgets/intersticial_ad.dart';

class RecipeCard extends StatelessWidget {
  final RecipeEntity recipe;

  const RecipeCard({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateWithAd(context),
      child: Card(
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
              Column(
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
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateWithAd(BuildContext context) async {
    await _showInterstitialAd(context, 0.35);
    if (context.mounted) {
      context.go(AppRoutesPath.recipeDetail, extra: recipe.id);
    }
  }

  Future<void> _showInterstitialAd(
      BuildContext context, double probability) async {
    double randomValue = Random().nextDouble();

    if (randomValue <= probability) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const InterstitialAdWidget();
        },
      );
    }
  }
}
