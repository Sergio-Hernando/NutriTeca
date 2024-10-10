import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_event.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_state.dart';
import 'dart:async';

import 'package:food_macros/presentation/shared/aliment_action.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AlimentRepositoryContract _repository;
  final StreamController<AlimentAction> _alimentController;

  SearchBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<AlimentAction> alimentAddedController,
  })  : _repository = repositoryContract,
        _alimentController = alimentAddedController,
        super(SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      await event.when(
        fetchAllAlimentsList: () =>
            _fetchAllAlimentsListEventToState(event, emit),
        applyFilters: (FiltersEntity filters) =>
            _applyFiltersToState(filters, emit),
        resetFilters: () => _resetFiltersToState(emit),
        updateFilters: (FiltersEntity filters) => _updateFilters(emit, filters),
        updateSearch: (List<AlimentEntity> searchResults) =>
            _mapUpdateSearchToState(event, emit, searchResults),
        refreshAllAlimentsList: (aliment) =>
            _mapRefreshAllAlimentsListEventToState(aliment, emit),
      );
    });

    // Suscripción al StreamController para escuchar eventos de nuevos alimentos
    _alimentController.stream.listen((aliment) {
      add(SearchEvent.refreshAllAlimentsList(aliment));
    });
  }

  Future<void> _fetchAllAlimentsListEventToState(
      SearchEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _repository.getAllAliments();

    emit(state.copyWith(
      screenStatus: const ScreenStatus.success(),
      aliments: data,
    ));
  }

  Future<void> _applyFiltersToState(
      FiltersEntity filters, Emitter<SearchState> emit) async {
    final filteredAliments = state.aliments.where((aliment) {
      return (filters.highFats ? (aliment.fats ?? 0) >= 10 : true) &&
          (filters.highProteins ? (aliment.proteins ?? 0) >= 10 : true) &&
          (filters.highCarbohydrates
              ? (aliment.carbohydrates ?? 0) >= 10
              : true) &&
          (filters.highCalories ? (aliment.calories ?? 0) >= 100 : true) &&
          (filters.supermarket != null
              ? aliment.supermarket == filters.supermarket
              : true);
    }).toList();

    emit(state.copyWith(aliments: filteredAliments));
  }

  Future<void> _resetFiltersToState(Emitter<SearchState> emit) async {
    emit(state.copyWith(aliments: await _repository.getAllAliments()));
  }

  Future<void> _updateFilters(
      Emitter<SearchState> emit, FiltersEntity filters) async {
    emit(state.copyWith(filters: filters));
  }

  Future<void> _mapUpdateSearchToState(SearchEvent event,
      Emitter<SearchState> emit, List<AlimentEntity> searchResults) async {
    emit(state.copyWith(aliments: searchResults));
  }

  Future<void> _mapRefreshAllAlimentsListEventToState(
      AlimentAction aliment, Emitter<SearchState> emit) async {
    final List<AlimentEntity> aliments = List.from(state.aliments);

    if (aliment.isAdd) {
      aliments.add(aliment.aliment);
    } else {
      aliments.removeWhere(
        (element) => element.id == aliment.aliment.id,
      );
    }

    emit(state.copyWith(
      aliments: aliments,
      screenStatus: const ScreenStatus.success(),
    ));
  }
}
