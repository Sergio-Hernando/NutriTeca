import 'package:food_macros/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required ScreenStatus screenStatus,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(screenStatus: ScreenStatus.initial());
  }
}
