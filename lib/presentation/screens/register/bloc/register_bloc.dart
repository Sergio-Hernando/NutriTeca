import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/repository_contracts/auth_repository_contract.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepositoryContract _authRepository;

  RegisterBloc({required AuthRepositoryContract authRepository})
      : _authRepository = authRepository,
        super(RegisterState.initial()) {
    on<RegisterEvent>((event, emit) async {
      await event.when(
        register: (email, password) =>
            _registerEventToState(email, password, emit),
      );
    });
  }

  Future<void> _registerEventToState(
      String email, String password, Emitter<RegisterState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final result = await _authRepository.register(email, password);

    result.fold(
      (failure) => emit(state.copyWith(
          screenStatus: const ScreenStatus.error(),
          errorMessage: failure.message)),
      (success) => emit(state.copyWith(
          screenStatus: const ScreenStatus.success(), errorMessage: null)),
    );
  }
}
