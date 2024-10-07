import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/request/recipe_request_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepositoryContract _repository;
  final AlimentRepositoryContract _alimentsRepository;

  RecipeBloc({
    required RecipeRepositoryContract repositoryContract,
    required AlimentRepositoryContract alimentRepositoryContract,
  })  : _repository = repositoryContract,
        _alimentsRepository = alimentRepositoryContract,
        super(RecipeState.initial()) {
    on<RecipeEvent>((event, emit) async {
      await event.when(
        saveRecipe: (recipeName, aliments) =>
            _saveRecipeEventToState(recipeName, aliments, event, emit),
        getRecipes: () => _getRecipesEventToState(event, emit),
        getAliments: () => _getAliments(emit),
      );
    });
  }

  Future<void> _saveRecipeEventToState(
      String recipeName,
      List<Map<String, dynamic>> aliments,
      RecipeEvent event,
      Emitter<RecipeState> emit) async {
    try {
      emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

      final recipeRequest =
          RecipeRequestEntity(name: recipeName, aliments: aliments);

      await _repository.createRecipe(recipeRequest);

      emit(state.copyWith(screenStatus: const ScreenStatus.success()));
    } catch (e) {
      emit(state.copyWith(screenStatus: ScreenStatus.error(e.toString())));
    }
  }

  Future<void> _getRecipesEventToState(
      RecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      emit(state.copyWith(screenStatus: const ScreenStatus.loading()));

      final recipes = await _repository.getAllRecipes();

      emit(state.copyWith(
          screenStatus: const ScreenStatus.success(), recipes: recipes));
    } catch (e) {
      emit(state.copyWith(screenStatus: ScreenStatus.error(e.toString())));
    }
  }

  Future<void> _getAliments(Emitter<RecipeState> emit) async {
    emit(state.copyWith(screenStatus: const ScreenStatus.loading()));
    final data = await _alimentsRepository.getAllAliments();

    emit(state.copyWith(
      screenStatus: const ScreenStatus.success(),
      aliments: data,
    ));
  }
}
