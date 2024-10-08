import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/request/recipe_request_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:food_macros/presentation/screens/add_recipe/bloc/add_recipe_event.dart';
import 'package:food_macros/presentation/screens/add_recipe/bloc/add_recipe_state.dart';

class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  final RecipeRepositoryContract _repository;
  final AlimentRepositoryContract _alimentsRepository;
  final StreamController<void> _recipeNotificationController;

  AddRecipeBloc({
    required RecipeRepositoryContract repositoryContract,
    required AlimentRepositoryContract alimentRepositoryContract,
    required StreamController<void> recipeNotificationController,
  })  : _repository = repositoryContract,
        _alimentsRepository = alimentRepositoryContract,
        _recipeNotificationController = recipeNotificationController,
        super(AddRecipeState.initial()) {
    on<AddRecipeEvent>((event, emit) async {
      await event.when(
        fetchAliments: () => _getAliments(emit),
        addRecipe: (recipeName, instructions, aliments) =>
            _saveRecipeEventToState(recipeName, instructions, aliments, emit),
      );
    });
  }

  Future<void> _getAliments(Emitter<AddRecipeState> emit) async {
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

  Future<void> _saveRecipeEventToState(String recipeName, String instructions,
      List<Map<String, dynamic>> aliments, Emitter<AddRecipeState> emit) async {
    try {
      emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

      final recipeRequest = RecipeRequestEntity(
          name: recipeName, aliments: aliments, instructions: instructions);

      await _repository.createRecipe(recipeRequest);

      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
      _recipeNotificationController.add(null);
    } catch (e) {
      emit(state.copyWith(screenStatus: ScreenStatus.error(e.toString())));
    }
  }
}
