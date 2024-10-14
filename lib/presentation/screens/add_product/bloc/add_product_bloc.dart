import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_event.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_state.dart';
import 'package:food_macros/presentation/shared/aliment_action.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AlimentRepositoryContract _repository;
  final StreamController<AlimentAction> _alimentController;

  AddProductBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<AlimentAction> alimentAddedController,
  })  : _repository = repositoryContract,
        _alimentController = alimentAddedController,
        super(AddProductState.initial()) {
    on<AddProductEvent>((event, emit) async {
      await event.when(
          addProduct: (aliment) =>
              _createAlimentEventToState(event, emit, aliment));
    });
  }

  Future<void> _createAlimentEventToState(AddProductEvent event,
      Emitter<AddProductState> emit, AlimentEntity aliment) async {
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
