import 'package:food_macros/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    required ScreenStatus screenStatus,
    required bool splashed,
  }) = _SplashState;

  factory SplashState.initial() {
    return const SplashState(
        screenStatus: ScreenStatus.initial(), splashed: false);
  }
}
