import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'recipe_detail_state.freezed.dart';

@freezed
class RecipeDetailState with _$RecipeDetailState {
  const factory RecipeDetailState({
    required ScreenStatus screenStatus,
    required RecipeEntity? recipe,
  }) = _RecipeDetailState;
  factory RecipeDetailState.initial() {
    return const RecipeDetailState(
        screenStatus: ScreenStatus.initial(), recipe: null);
  }
}
