import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_screen_event.freezed.dart';

@freezed
class BaseScreenEvent with _$BaseScreenEvent {
  const factory BaseScreenEvent.logOut() = _LogOut;
}
