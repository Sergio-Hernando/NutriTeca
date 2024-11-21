import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutri_teca/core/types/screen_status.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required ScreenStatus screenStatus,
    String? errorMessage,
  }) = _RegisterState;

  factory RegisterState.initial() {
    return const RegisterState(
      screenStatus: ScreenStatus.initial(),
      errorMessage: null,
    );
  }
}
