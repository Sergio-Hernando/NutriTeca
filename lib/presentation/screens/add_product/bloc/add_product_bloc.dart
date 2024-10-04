import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_event.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AlimentRepositoryContract _repository;
  final StreamController<void> _alimentController;

  AddProductBloc({
    required AlimentRepositoryContract repositoryContract,
    required StreamController<void> alimentAddedController,
  })  : _repository = repositoryContract,
        _alimentController = alimentAddedController,
        super(AddProductState.initial()) {
    on<AddProductEvent>((event, emit) async {
      await event.when(
          addProduct: (aliment) => _createAliment(event, emit, aliment));
    });
  }

  Future<void> _createAliment(AddProductEvent event,
      Emitter<AddProductState> emit, AlimentRequestEntity aliment) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _repository.createAliment(aliment);

    if (data == 0) {
      emit(state.copyWith(screenStatus: const ScreenStatus.error()));
    } else {
      _alimentController.add(null);
      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
    }
  }
}
