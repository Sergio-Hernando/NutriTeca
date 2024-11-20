import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/repository_contracts/auth_repository_contract.dart';
import 'package:nutri_teca/presentation/screens/base_screen/bloc/base_screen_event.dart';
import 'package:nutri_teca/presentation/screens/base_screen/bloc/base_screen_state.dart';

class BaseScreenBloc extends Bloc<BaseScreenEvent, BaseScreenState> {
  final AuthRepositoryContract _authRepositoryContract;

  BaseScreenBloc({
    required AuthRepositoryContract authRepositoryContract,
  })  : _authRepositoryContract = authRepositoryContract,
        super(BaseScreenState.initial()) {
    on<BaseScreenEvent>((event, emit) async {
      await event.when(logOut: () => _logOutEventToState(emit));
    });
  }

  Future<void> _logOutEventToState(Emitter<BaseScreenState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

    final logOutResult = await _authRepositoryContract.logout();

    logOutResult.fold(
      (failure) => emit(state.copyWith(
        screenStatus: const ScreenStatus.error(),
      )),
      (success) => emit(state.copyWith(
        screenStatus: const ScreenStatus.success(),
      )),
    );
  }
}
