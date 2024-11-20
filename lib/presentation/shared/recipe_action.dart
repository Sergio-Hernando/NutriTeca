import 'package:nutri_teca/domain/models/recipe_entity.dart';

class RecipeAction {
  final RecipeEntity recipe;
  final bool isAdd;

  RecipeAction({required this.recipe, required this.isAdd});
}
