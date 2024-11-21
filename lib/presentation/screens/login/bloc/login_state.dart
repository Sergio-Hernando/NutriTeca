import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutri_teca/core/types/screen_status.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required ScreenStatus screenStatus,
    String? errorMessage,
  }) = _LoginState;

  factory LoginState.initial() {
    return const LoginState(
      screenStatus: ScreenStatus.initial(),
      errorMessage: null,
    );
  }
}
