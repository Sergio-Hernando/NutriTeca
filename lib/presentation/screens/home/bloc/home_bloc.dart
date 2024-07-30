import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/repository_contracts/home_repository_contract.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_event.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryContract _repository;

  HomeBloc({
    required HomeRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(fetchHome: () => _fetchHomeEventToState(event, emit));
    });
  }

  Future<void> _fetchHomeEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
  }
}
