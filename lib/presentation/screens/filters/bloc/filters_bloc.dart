import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/filters/bloc/filters_event.dart';
import 'package:food_macros/presentation/screens/filters/bloc/filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersState.initial()) {
    on<FiltersEvent>((event, emit) async {
      await event.when(
        filterAliments: (highFats, highProteins, highCarbohydrates,
                highCalories, supermarket, aliments) =>
            _filterAlimentsListEventToState(event, emit, highFats, highProteins,
                highCarbohydrates, highCalories, supermarket, aliments),
      );
    });
  }

  Future<void> _filterAlimentsListEventToState(
      FiltersEvent event,
      Emitter<FiltersState> emit,
      bool? highFats,
      bool? highProteins,
      bool? highCarbohydrates,
      bool? highCalories,
      String? supermarket,
      List<AlimentEntity>? aliments) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final filteredAliments = aliments!.where((aliment) {
      if (supermarket != null &&
          supermarket.isNotEmpty &&
          aliment.supermarket != supermarket) {
        return false;
      }
      if (highFats == true && aliment.fats < 10) {
        return false;
      }
      if (highProteins == true && aliment.proteins < 10) {
        return false;
      }
      if (highCarbohydrates == true && aliment.carbohydrates < 10) {
        return false;
      }
      if (highCalories == true && aliment.calories < 100) {
        return false;
      }
      return true;
    }).toList();

    emit(state.copyWith(aliments: filteredAliments));
  }
}
