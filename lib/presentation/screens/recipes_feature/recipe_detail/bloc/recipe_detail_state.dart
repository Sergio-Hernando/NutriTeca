import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'recipe_detail_state.freezed.dart';

@freezed
class RecipeDetailState with _$RecipeDetailState {
  const factory RecipeDetailState({
    required ScreenStatus screenStatus,
    required RecipeEntity? recipe,
    required List<AlimentEntity> aliments,
  }) = _RecipeDetailState;
  factory RecipeDetailState.initial() {
    return const RecipeDetailState(
      screenStatus: ScreenStatus.initial(),
      recipe: null,
      aliments: [],
    );
  }
}
