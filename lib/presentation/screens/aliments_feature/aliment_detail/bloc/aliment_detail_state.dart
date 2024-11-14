import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aliment_detail_state.freezed.dart';

@freezed
class AlimentDetailState with _$AlimentDetailState {
  const factory AlimentDetailState({
    required ScreenStatus screenStatus,
    required AlimentEntity? aliment,
    required List<RecipeEntity>? recipes,
  }) = _AlimentDetailState;
  factory AlimentDetailState.initial() {
    return const AlimentDetailState(
        screenStatus: ScreenStatus.initial(), aliment: null, recipes: []);
  }
}
