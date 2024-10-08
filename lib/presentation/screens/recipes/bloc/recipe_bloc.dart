import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepositoryContract _repository;
  final StreamController<void> _recipeNotificationController;

  RecipeBloc(
      {required RecipeRepositoryContract repositoryContract,
      required StreamController<void> recipeNotificationController})
      : _repository = repositoryContract,
        _recipeNotificationController = recipeNotificationController,
        super(RecipeState.initial()) {
    on<RecipeEvent>((event, emit) async {
      await event.when(
        getRecipes: () => _getRecipesEventToState(emit),
        updateSearch: (searchResults) =>
            _mapUpdateSearchToState(emit, searchResults),
      );
    });

    _recipeNotificationController.stream.listen((_) {
      add(const RecipeEvent.getRecipes());
    });
  }

  Future<void> _getRecipesEventToState(Emitter<RecipeState> emit) async {
    try {
      emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

      final recipes = await _repository.getAllRecipes();

      if (recipes.isEmpty) {
        emit(state.copyWith(
          screenStatus: const ScreenStatus.success(),
          recipes: [],
        ));
      } else {
        emit(state.copyWith(
          screenStatus: const ScreenStatus.success(),
          recipes: recipes,
        ));
      }
    } catch (e) {
      emit(state.copyWith(screenStatus: ScreenStatus.error(e.toString())));
    }
  }

  Future<void> _mapUpdateSearchToState(
      Emitter<RecipeState> emit, List<RecipeEntity> searchResults) async {
    emit(state.copyWith(recipes: searchResults));
  }
}
