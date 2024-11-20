import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/repository_contracts/auth_repository_contract.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryContract _authRepository;

  LoginBloc({required AuthRepositoryContract authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      await event.when(
        login: (email, password) => _loginEventToState(email, password, emit),
      );
    });
  }

  Future<void> _loginEventToState(
      String email, String password, Emitter<LoginState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final result = await _authRepository.login(email, password);

    result.fold(
      (failure) => emit(state.copyWith(
          screenStatus: const ScreenStatus.error(),
          errorMessage: failure.message)),
      (success) => emit(state.copyWith(
          screenStatus: const ScreenStatus.success(), errorMessage: null)),
    );
  }
}
