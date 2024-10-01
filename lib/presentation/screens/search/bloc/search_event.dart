import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.fetchAllAlimentsList() = _FetchAllAlimentsList;
  const factory SearchEvent.applyFilters(FiltersEntity filters) = _ApplyFilters;
  const factory SearchEvent.resetFilters() = _ResetFilters;
  const factory SearchEvent.updateFilters(FiltersEntity filters) =
      _UpdateFilters;
  const factory SearchEvent.updateSearch(List<AlimentEntity> searchResults) =
      _UpdateSearch;
}
