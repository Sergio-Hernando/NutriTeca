import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_event.freezed.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.saveRecipe({
    required String recipeName,
    required List<Map<String, dynamic>> aliments,
  }) = _SaveRecipe;

  const factory RecipeEvent.getRecipes() = _GetRecipes;
  const factory RecipeEvent.getAliments() = _GetAliments;
}
