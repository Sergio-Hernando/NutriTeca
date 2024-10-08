import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_recipe_event.freezed.dart';

@freezed
class AddRecipeEvent with _$AddRecipeEvent {
  const factory AddRecipeEvent.fetchAliments() = _FetchAliments;
  const factory AddRecipeEvent.addRecipe(
      {required String recipeName,
      required String instructions,
      required List<Map<String, dynamic>> aliments}) = _AddRecipe;
}
