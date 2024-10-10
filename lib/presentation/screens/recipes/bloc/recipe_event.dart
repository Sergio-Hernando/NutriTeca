import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_event.freezed.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.getRecipes() = _GetRecipes;
  const factory RecipeEvent.refreshRecipes(RecipeEntity recipe) =
      _RefreshRecipes;
  const factory RecipeEvent.updateSearch(List<RecipeEntity> searchResults) =
      _UpdateSearch;
}
