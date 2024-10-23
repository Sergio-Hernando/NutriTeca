import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aliments_state.freezed.dart';

@freezed
class AlimentsState with _$AlimentsState {
  const factory AlimentsState(
      {required ScreenStatus screenStatus,
      required List<AlimentEntity> aliments,
      required List<AlimentEntity> allAliments,
      required FiltersEntity filters}) = _AlimentsState;

  factory AlimentsState.initial() {
    return AlimentsState(
        screenStatus: const ScreenStatus.initial(),
        aliments: [],
        allAliments: [],
        filters: FiltersEntity(
            highCalories: false,
            highCarbohydrates: false,
            highFats: false,
            highProteins: false,
            supermarket: ''));
  }
}
