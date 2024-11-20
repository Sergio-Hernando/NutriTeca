import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:nutri_teca/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:nutri_teca/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:nutri_teca/presentation/shared/recipe_action.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final RecipeRepositoryContract _repository;
  final AlimentRepositoryContract _alimentRepository;
  final StreamController<RecipeAction> _recipeController;
  RecipeDetailBloc({
    required RecipeRepositoryContract repository,
    required StreamController<RecipeAction> recipeController,
    required AlimentRepositoryContract alimentRepository,
  })  : _repository = repository,
        _recipeController = recipeController,
        _alimentRepository = alimentRepository,
        super(RecipeDetailState.initial()) {
    on<RecipeDetailEvent>((event, emit) async {
      await event.when(
        getAliments: () => _getAlimentsEventToState(emit),
        getRecipe: (recipeId) => _getRecipeEventToState(recipeId, emit),
        editRecipe: (recipe) => _editRecipeEventToState(recipe, emit),
        deleteRecipe: (recipeId) => _deleteRecipeEventToState(recipeId, emit),
      );
    });
  }

  Future<void> _getAlimentsEventToState(Emitter<RecipeDetailState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    try {
      final result = await _alimentRepository.getAllAliments();
      emit(state.copyWith(
          screenStatus: const ScreenStatus.success(), aliments: result));
    } catch (e) {
      emit(state.copyWith(screenStatus: const ScreenStatus.error()));
    }
  }

  Future<void> _getRecipeEventToState(
      int recipeId, Emitter<RecipeDetailState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    try {
      final result = await _repository.getRecipe(recipeId);
      emit(state.copyWith(
          screenStatus: const ScreenStatus.success(), recipe: result));
    } catch (e) {
      emit(state.copyWith(screenStatus: const ScreenStatus.error()));
    }
  }

  Future<void> _editRecipeEventToState(
      RecipeEntity recipe, Emitter<RecipeDetailState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final result = await _repository.updateRecipe(recipe);

    if (result != null) {
      _recipeController.add(RecipeAction(recipe: result, isAdd: true));
      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
    } else {
      emit(state.copyWith(screenStatus: const ScreenStatus.error()));
    }
  }

  Future<void> _deleteRecipeEventToState(
      int recipeId, Emitter<RecipeDetailState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final result = await _repository.deleteRecipe(recipeId);

    if (!result) {
      emit(state.copyWith(screenStatus: const ScreenStatus.error()));
    } else {
      _recipeController
          .add(RecipeAction(recipe: RecipeEntity(id: recipeId), isAdd: false));
      emit(state.copyWith(
        screenStatus: const ScreenStatus.success(),
      ));
    }
  }
}
