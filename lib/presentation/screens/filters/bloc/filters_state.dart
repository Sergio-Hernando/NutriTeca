import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters_state.freezed.dart';

@freezed
class FiltersState with _$FiltersState {
  const factory FiltersState({
    required ScreenStatus screenStatus,
    required List<AlimentEntity> aliments,
  }) = _FiltersState;

  factory FiltersState.initial() {
    return const FiltersState(
        screenStatus: ScreenStatus.initial(), aliments: []);
  }
}
