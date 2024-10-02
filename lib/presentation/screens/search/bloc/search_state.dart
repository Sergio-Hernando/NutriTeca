import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState(
      {required ScreenStatus screenStatus,
      required List<AlimentEntity> aliments,
      required FiltersEntity filters}) = _SearchState;

  factory SearchState.initial() {
    return SearchState(
        screenStatus: const ScreenStatus.initial(),
        aliments: [],
        filters: FiltersEntity(
            highCalories: false,
            highCarbohydrates: false,
            highFats: false,
            highProteins: false,
            supermarket: ''));
  }
}
