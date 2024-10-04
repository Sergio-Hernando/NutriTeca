import 'package:food_macros/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aliment_detail_state.freezed.dart';

@freezed
class AlimentDetailState with _$AlimentDetailState {
  const factory AlimentDetailState({
    required ScreenStatus screenStatus,
  }) = _AlimentDetailState;
  factory AlimentDetailState.initial() {
    return const AlimentDetailState(screenStatus: ScreenStatus.initial());
  }
}
