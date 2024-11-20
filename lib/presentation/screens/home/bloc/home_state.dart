import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/additive_entity.dart';
import 'package:nutri_teca/domain/models/monthly_spent_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required ScreenStatus screenStatus,
    required List<MonthlySpentEntity> monthlySpent,
    required List<AdditiveEntity> additives,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
        screenStatus: ScreenStatus.initial(), monthlySpent: [], additives: []);
  }
}
