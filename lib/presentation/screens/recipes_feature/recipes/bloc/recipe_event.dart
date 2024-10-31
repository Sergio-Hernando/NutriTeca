import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:nutri_teca/presentation/shared/recipe_action.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_event.freezed.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.getRecipes() = _GetRecipes;
  const factory RecipeEvent.refreshRecipes(RecipeAction recipe) =
      _RefreshRecipes;
  const factory RecipeEvent.updateSearch(
      List<RecipeEntity> searchResults, String enteredKeyword) = _UpdateSearch;
}
