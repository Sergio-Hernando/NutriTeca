import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/monthly_spent_repository_contract.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_event.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_state.dart';

class BaseScreenBloc extends Bloc<BaseScreenEvent, BaseScreenState> {
  final AlimentRepositoryContract _alimentsRepository;
  final MonthlySpentRepositoryContract _monthlySpentRepository;
  final StreamController<MonthlySpentEntity>
      _monthlySpentNotificationController;
  BaseScreenBloc({
    required AlimentRepositoryContract alimentRepositoryContract,
    required MonthlySpentRepositoryContract monthlySpentRepository,
    required StreamController<MonthlySpentEntity>
        monthlySpentNotificationController,
  })  : _alimentsRepository = alimentRepositoryContract,
        _monthlySpentRepository = monthlySpentRepository,
        _monthlySpentNotificationController =
            monthlySpentNotificationController,
        super(BaseScreenState.initial()) {
    on<BaseScreenEvent>((event, emit) async {
      await event.when(
          getAllAlimentsList: () => _getAlimentsEventToState(emit),
          addMonthlySpent: (aliment) =>
              _addMonthlySpentEventToState(event, emit, aliment));
    });
  }

  Future<void> _getAlimentsEventToState(Emitter<BaseScreenState> emit) async {
    try {
      emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

      final aliments = await _alimentsRepository.getAllAliments();

      emit(state.copyWith(
        screenStatus: const ScreenStatus.success(),
        aliments: aliments,
      ));
    } catch (e) {
      emit(state.copyWith(screenStatus: ScreenStatus.error(e.toString())));
    }
  }

  Future<void> _addMonthlySpentEventToState(BaseScreenEvent event,
      Emitter<BaseScreenState> emit, MonthlySpentEntity monthlySpent) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _monthlySpentRepository.createMonthlySpent(monthlySpent);

    if (data == null) {
      emit(state.copyWith(
          screenStatus: const ScreenStatus.error('El gasto no se ha creado')));
    } else {
      _monthlySpentNotificationController.add(data);
      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
    }
  }
}
