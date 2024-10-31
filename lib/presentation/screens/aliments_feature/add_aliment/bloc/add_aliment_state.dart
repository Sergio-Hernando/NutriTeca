import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_aliment_state.freezed.dart';

@freezed
class AddAlimentState with _$AddAlimentState {
  const factory AddAlimentState({
    required ScreenStatus screenStatus,
  }) = _AddAlimentState;

  factory AddAlimentState.initial() {
    return const AddAlimentState(screenStatus: ScreenStatus.initial());
  }
}
