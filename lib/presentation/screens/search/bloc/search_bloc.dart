import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_event.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_state.dart';
import 'dart:async';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AlimentRepositoryContract _repository;
  final StreamController<void> _alimentAddedController;

  SearchBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<void> alimentAddedController,
  })  : _repository = repositoryContract,
        _alimentAddedController = alimentAddedController,
        super(SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      await event.when(
        fetchAllAlimentsList: () =>
            _fetchAllAlimentsListEventToState(event, emit),
        filterAliments: (
          highFats,
          highProteins,
          highCarbohydrates,
          highCalories,
          supermarket,
        ) =>
            _filterAlimentsListEventToState(
          event,
          emit,
          highFats,
          highProteins,
          highCarbohydrates,
          highCalories,
          supermarket,
        ),
      );
    });

    // Suscripción al StreamController para escuchar eventos de nuevos alimentos
    _alimentAddedController.stream.listen((_) {
      add(const SearchEvent.fetchAllAlimentsList());
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

  Future<void> _filterAlimentsListEventToState(
    SearchEvent event,
    Emitter<SearchState> emit,
    bool? highFats,
    bool? highProteins,
    bool? highCarbohydrates,
    bool? highCalories,
    String? supermarket,
  ) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final filteredAliments = state.aliments.where((aliment) {
      if (supermarket != null && aliment.supermarket != supermarket) {
        return false;
      }
      if (highFats == true && aliment.fats < 10) {
        return false;
      }
      if (highProteins == true && aliment.proteins < 10) {
        return false;
      }
      if (highCarbohydrates == true && aliment.carbohydrates < 10) {
        return false;
      }
      if (highCalories == true && aliment.calories < 100) {
        return false;
      }
      return true;
    }).toList();

    emit(state.copyWith(aliments: filteredAliments));
  }
}
