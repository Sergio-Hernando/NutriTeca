import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_screen_state.freezed.dart';

@freezed
class BaseScreenState with _$BaseScreenState {
  const factory BaseScreenState({
    required ScreenStatus screenStatus,
  }) = _BaseScreenState;

  factory BaseScreenState.initial() => const BaseScreenState(
        screenStatus: ScreenStatus.initial(),
      );
}
