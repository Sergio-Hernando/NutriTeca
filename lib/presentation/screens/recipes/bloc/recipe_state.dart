import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState({
    required ScreenStatus screenStatus,
    required List<AlimentEntity> aliments,
    required List<RecipeEntity> recipes,
  }) = _RecipeState;

  factory RecipeState.initial() {
    return const RecipeState(
        screenStatus: ScreenStatus.initial(), aliments: [], recipes: []);
  }
}
