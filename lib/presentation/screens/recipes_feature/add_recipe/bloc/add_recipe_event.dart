import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_recipe_event.freezed.dart';

@freezed
class AddRecipeEvent with _$AddRecipeEvent {
  const factory AddRecipeEvent.fetchAliments() = _FetchAliments;
  const factory AddRecipeEvent.addRecipe({required RecipeEntity recipe}) =
      _AddRecipe;
}
