import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/domain/repository_contracts/additive_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/monthly_spent_repository_contract.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_event.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MonthlySpentRepositoryContract _monthlySpentRepository;
  final AdditiveRepositoryContract _additiveRepositoryContract;
  final StreamController<MonthlySpentEntity> _monthlySpentController;

  HomeBloc({
    required MonthlySpentRepositoryContract monthlySpentRepository,
    required AdditiveRepositoryContract additiveRepositoryContract,
    required StreamController<MonthlySpentEntity> monthlySpentController,
  })  : _monthlySpentRepository = monthlySpentRepository,
        _additiveRepositoryContract = additiveRepositoryContract,
        _monthlySpentController = monthlySpentController,
        super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
          getAllMonthlySpent: () =>
              _getAllMonthlySpentEventToState(event, emit),
          getAdditives: () => _getAadditivesEventToState(event, emit),
          deleteMonthlySpent: (id) => _deleteMonthlySpentEventToState(id, emit),
          refreshMonthlySpent: (monthlySpentEntity) =>
              _refreshMonthlySpentEventToState(monthlySpentEntity, emit));
    });
    _monthlySpentController.stream.listen((aliment) {
      add(HomeEvent.refreshMonthlySpent(aliment));
    });
  }

  Future<void> _getAllMonthlySpentEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _monthlySpentRepository.getAllMonthlySpent();

    if (data.isNotEmpty) {
      List<MonthlySpentEntity> top10MonthlySpent = data
          .where((monthlySpent) => monthlySpent.quantity > 0)
          .toList()
        ..sort((a, b) => b.quantity.compareTo(a.quantity));

      emit(state.copyWith(
          screenStatus: const ScreenStatus.success(),
          monthlySpent: top10MonthlySpent.take(10).toList()));
    } else {
      emit(state.copyWith(
          screenStatus:
              const ScreenStatus.error('Los gastos no se han recuperado')));
    }
  }

  Future<void> _deleteMonthlySpentEventToState(
      int id, Emitter<HomeState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _monthlySpentRepository.deleteMonthlySpent(id);
    final List<MonthlySpentEntity> monthlySpent = List.from(state.monthlySpent);

    if (data != 0) {
      monthlySpent.removeWhere(
        (element) => element.id == data,
      );

      emit(state.copyWith(
          screenStatus: const ScreenStatus.success(),
          monthlySpent: monthlySpent));
    } else {
      emit(state.copyWith(
          screenStatus:
              const ScreenStatus.error('Los gastos no se han recuperado')));
    }
  }

  Future<void> _refreshMonthlySpentEventToState(
      MonthlySpentEntity newMonthlySpent, Emitter<HomeState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final List<MonthlySpentEntity> monthlySpent = List.from(state.monthlySpent);

    monthlySpent.add(newMonthlySpent);

    emit(state.copyWith(
        screenStatus: const ScreenStatus.success(),
        monthlySpent: monthlySpent));
  }

  Future<void> _getAadditivesEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _additiveRepositoryContract.getAdditives();

    if (data.isNotEmpty) {
      emit(state.copyWith(
          screenStatus: const ScreenStatus.success(), additives: data));
    } else {
      emit(state.copyWith(
          screenStatus:
              const ScreenStatus.error('Los aditivos no se han recuperado')));
    }
  }
}
