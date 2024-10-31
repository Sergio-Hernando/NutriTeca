import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_event.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      await event.when(
          unSplashInMilliseconds: (milliseconds) =>
              _unSplashInMilliseconds(event, emit, milliseconds));
    });
  }

  Future<void> _unSplashInMilliseconds(
      SplashEvent event, Emitter<SplashState> emit, int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    emit(state.copyWith(splashed: true));
  }
}
