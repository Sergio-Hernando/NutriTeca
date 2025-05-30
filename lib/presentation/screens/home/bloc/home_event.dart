import 'package:nutri_teca/domain/models/monthly_spent_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getAllMonthlySpent() = _GetAllMonthlySpent;
  const factory HomeEvent.getAdditives() = _GetAdditives;
  const factory HomeEvent.deleteMonthlySpent(int id) = _DeleteMonthlySpent;
  const factory HomeEvent.refreshMonthlySpent(MonthlySpentEntity monthlySpent) =
      _RefreshMonthlySpent;
  const factory HomeEvent.checkMonthFirstDay() = _CheckMonthFirstDay;
}
