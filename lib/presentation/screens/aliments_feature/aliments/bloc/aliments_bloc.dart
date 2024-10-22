import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_state.dart';
import 'dart:async';

import 'package:food_macros/presentation/shared/aliment_action.dart';

class AlimentsBloc extends Bloc<AlimentsEvent, AlimentsState> {
  final AlimentRepositoryContract _repository;
  final StreamController<AlimentAction> _alimentController;

  AlimentsBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<AlimentAction> alimentAddedController,
  })  : _repository = repositoryContract,
        _alimentController = alimentAddedController,
        super(AlimentsState.initial()) {
    on<AlimentsEvent>((event, emit) async {
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

    _alimentController.stream.listen((aliment) {
      add(AlimentsEvent.refreshAllAlimentsList(aliment));
    });
  }

  Future<void> _fetchAllAlimentsListEventToState(
      AlimentsEvent event, Emitter<AlimentsState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _repository.getAllAliments();

    emit(state.copyWith(
      screenStatus: const ScreenStatus.success(),
      aliments: data,
    ));
  }

  Future<void> _applyFiltersToState(
      FiltersEntity filters, Emitter<AlimentsState> emit) async {
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

  Future<void> _resetFiltersToState(Emitter<AlimentsState> emit) async {
    emit(state.copyWith(aliments: await _repository.getAllAliments()));
  }

  Future<void> _updateFilters(
      Emitter<AlimentsState> emit, FiltersEntity filters) async {
    emit(state.copyWith(filters: filters));
  }

  Future<void> _mapUpdateSearchToState(AlimentsEvent event,
      Emitter<AlimentsState> emit, List<AlimentEntity> searchResults) async {
    emit(state.copyWith(aliments: searchResults));
  }

  Future<void> _mapRefreshAllAlimentsListEventToState(
      AlimentAction aliment, Emitter<AlimentsState> emit) async {
    final List<AlimentEntity> aliments = List.from(state.aliments);

    if (aliment.isAdd) {
      final int index =
          aliments.indexWhere((element) => element.id == aliment.aliment.id);

      if (index != -1) {
        aliments[index] = aliment.aliment;
      } else {
        aliments.add(aliment.aliment);
      }
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
