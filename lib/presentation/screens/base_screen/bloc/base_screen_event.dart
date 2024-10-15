import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_screen_event.freezed.dart';

@freezed
class BaseScreenEvent with _$BaseScreenEvent {
  const factory BaseScreenEvent.getAllAlimentsList() = _GetAllAlimentsList;
  const factory BaseScreenEvent.addMonthlySpent(MonthlySpentEntity aliment) =
      _AddAliment;
}
