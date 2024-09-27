import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters_event.freezed.dart';

@freezed
class FiltersEvent with _$FiltersEvent {
  const factory FiltersEvent.filterAliments({
    bool? highFats,
    bool? highProteins,
    bool? highCarbohydrates,
    bool? highCalories,
    String? supermarket,
    List<AlimentEntity>? aliments,
  }) = _FilterAliments;
}
