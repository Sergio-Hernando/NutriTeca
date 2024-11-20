import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState({
    required ScreenStatus screenStatus,
    required List<AlimentEntity> aliments,
    required List<RecipeEntity> recipes,
    required List<RecipeEntity> allRecipes,
  }) = _RecipeState;

  factory RecipeState.initial() {
    return const RecipeState(
        screenStatus: ScreenStatus.initial(),
        aliments: [],
        recipes: [],
        allRecipes: []);
  }
}
