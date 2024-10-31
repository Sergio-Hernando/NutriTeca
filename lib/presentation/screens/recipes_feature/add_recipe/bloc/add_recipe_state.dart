import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';

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
