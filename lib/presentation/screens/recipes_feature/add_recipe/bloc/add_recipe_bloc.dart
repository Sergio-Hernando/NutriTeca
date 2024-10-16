import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_state.dart';
import 'package:food_macros/presentation/shared/recipe_action.dart';

class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  final RecipeRepositoryContract _repository;
  final AlimentRepositoryContract _alimentsRepository;
  final StreamController<RecipeAction> _recipeNotificationController;

  AddRecipeBloc({
    required RecipeRepositoryContract repositoryContract,
    required AlimentRepositoryContract alimentRepositoryContract,
    required StreamController<RecipeAction> recipeNotificationController,
  })  : _repository = repositoryContract,
        _alimentsRepository = alimentRepositoryContract,
        _recipeNotificationController = recipeNotificationController,
        super(AddRecipeState.initial()) {
    on<AddRecipeEvent>((event, emit) async {
      await event.when(
        fetchAliments: () => _getAlimentsEventToState(emit),
        addRecipe: (recipe) => _saveRecipeEventToState(recipe, emit),
      );
    });
  }

  Future<void> _getAlimentsEventToState(Emitter<AddRecipeState> emit) async {
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

  Future<void> _saveRecipeEventToState(
      RecipeEntity recipe, Emitter<AddRecipeState> emit) async {
    try {
      emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

      final result = await _repository.createRecipe(recipe);

      if (result == null) {
        emit(state.copyWith(
            screenStatus:
                const ScreenStatus.error('El alimento no se ha creado')));
      } else {
        _recipeNotificationController
            .add(RecipeAction(recipe: result, isAdd: true));
        emit(state.copyWith(screenStatus: const ScreenStatus.success()));
      }
    } catch (e) {
      emit(state.copyWith(screenStatus: ScreenStatus.error(e.toString())));
    }
  }
}
