import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.fetchAllAlimentsList() = _FetchAllAlimentsList;
  const factory SearchEvent.filterAliments({
    bool? highFats,
    bool? highProteins,
    bool? highCarbohydrates,
    bool? highCalories,
    String? supermarket,
  }) = _FilterAliments;
}
