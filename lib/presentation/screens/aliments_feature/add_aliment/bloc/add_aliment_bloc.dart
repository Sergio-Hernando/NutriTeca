import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_event.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_state.dart';
import 'package:nutri_teca/presentation/shared/aliment_action.dart';

class AddAlimentBloc extends Bloc<AddAlimentEvent, AddAlimentState> {
  final AlimentRepositoryContract _repository;
  final StreamController<AlimentAction> _alimentController;

  AddAlimentBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<AlimentAction> alimentAddedController,
  })  : _repository = repositoryContract,
        _alimentController = alimentAddedController,
        super(AddAlimentState.initial()) {
    on<AddAlimentEvent>((event, emit) async {
      await event.when(
          addAliment: (aliment) =>
              _createAlimentEventToState(event, emit, aliment));
    });
  }

  Future<void> _createAlimentEventToState(AddAlimentEvent event,
      Emitter<AddAlimentState> emit, AlimentEntity aliment) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _repository.createAliment(aliment);

    if (data == null) {
      emit(state.copyWith(
          screenStatus:
              const ScreenStatus.error('El alimento no se ha creado')));
    } else {
      _alimentController.add(AlimentAction(aliment: aliment, isAdd: true));
      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
    }
  }
}
