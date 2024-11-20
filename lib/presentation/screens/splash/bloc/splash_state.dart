import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    required ScreenStatus screenStatus,
    required bool splashed,
    required String? userId,
  }) = _SplashState;

  factory SplashState.initial() {
    return const SplashState(
        screenStatus: ScreenStatus.initial(), splashed: false, userId: '');
  }
}
