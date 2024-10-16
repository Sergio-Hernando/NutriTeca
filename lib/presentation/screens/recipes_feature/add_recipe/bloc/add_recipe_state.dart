import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

part 'add_recipe_state.freezed.dart';

@freezed
class AddRecipeState with _$AddRecipeState {
  const factory AddRecipeState({
    required ScreenStatus screenStatus,
    required List<AlimentEntity> aliments,
  }) = _AddRecipeState;

  factory AddRecipeState.initial() => const AddRecipeState(
        screenStatus: ScreenStatus.initial(),
        aliments: [],
      );
}
