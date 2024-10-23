import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/presentation/shared/aliment_action.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aliments_event.freezed.dart';

@freezed
class AlimentsEvent with _$AlimentsEvent {
  const factory AlimentsEvent.fetchAllAlimentsList() = _FetchAllAlimentsList;
  const factory AlimentsEvent.refreshAllAlimentsList(AlimentAction aliment) =
      _RefreshAllAlimentsList;
  const factory AlimentsEvent.applyFilters(FiltersEntity filters) =
      _ApplyFilters;
  const factory AlimentsEvent.resetFilters() = _ResetFilters;
  const factory AlimentsEvent.updateFilters(FiltersEntity filters) =
      _UpdateFilters;
  const factory AlimentsEvent.updateSearch(
      List<AlimentEntity> searchResults, String enteredKeyword) = _UpdateSearch;
}
