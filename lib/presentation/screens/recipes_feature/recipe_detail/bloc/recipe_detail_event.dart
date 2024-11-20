import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_event.freezed.dart';

@freezed
class RecipeDetailEvent with _$RecipeDetailEvent {
  const factory RecipeDetailEvent.getAliments() = _GetAliments;
  const factory RecipeDetailEvent.getRecipe(int recipeId) = _GetRecipe;
  const factory RecipeDetailEvent.editRecipe(RecipeEntity recipe) = _EditRecipe;
  const factory RecipeDetailEvent.deleteRecipe(int recipeId) = _DeleteRecipe;
}
