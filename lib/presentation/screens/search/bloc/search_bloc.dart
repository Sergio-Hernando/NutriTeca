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
      screenStatus: data.isNotEmpty
          ? const ScreenStatus.success()
          : const ScreenStatus.error(),
      aliments: data,
    ));
  }
}
