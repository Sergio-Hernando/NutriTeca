import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.login(String email, String password) = _Login;
  const factory LoginEvent.loginWithGoogle() = _LoginWithGoogle;
}
