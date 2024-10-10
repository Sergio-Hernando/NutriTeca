import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/presentation/screens/aliment_detail/bloc/aliment_detail_event.dart';
import 'package:food_macros/presentation/screens/aliment_detail/bloc/aliment_detail_state.dart';
import 'package:food_macros/presentation/shared/aliment_action.dart';

class AlimentDetailBloc extends Bloc<AlimentDetailEvent, AlimentDetailState> {
  final AlimentRepositoryContract _repository;
  final StreamController<AlimentAction> _alimentController;

  AlimentDetailBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<AlimentAction> alimentController,
  })  : _repository = repositoryContract,
        _alimentController = alimentController,
        super(AlimentDetailState.initial()) {
    on<AlimentDetailEvent>((event, emit) async {
      await event.when(
          deleteAliment: (alimentId) =>
              _deleteAlimentEventToState(event, emit, alimentId));
    });
  }

  Future<void> _deleteAlimentEventToState(AlimentDetailEvent event,
      Emitter<AlimentDetailState> emit, int alimentId) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final result = await _repository.deleteAliment(alimentId);

    if (!result) {
      emit(state.copyWith(
          screenStatus: const ScreenStatus.error(
              'El alimento no se ha eliminado correctamente')));
    } else {
      _alimentController.add(
          AlimentAction(aliment: AlimentEntity(id: alimentId), isAdd: false));
      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
    }
  }
}
