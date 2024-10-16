import 'package:food_macros/data/data_source_contracts/recipe_data_source_contract.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/domain/repository_contracts/recipe_repository_contract.dart';

class RecipeRepository implements RecipeRepositoryContract {
  final RecipeDataSourceContract _recipeDataSourceContract;

  RecipeRepository(this._recipeDataSourceContract);

  @override
  Future<RecipeEntity?> createRecipe(RecipeEntity recipe) async {
    final recipeId =
        await _recipeDataSourceContract.createRecipe(recipe.toDataModel());

    return getRecipe(recipeId?.id ?? 0);
  }

  @override
  Future<RecipeEntity?> getRecipe(int id) async {
    final recipe = await _recipeDataSourceContract.getRecipe(id);

    return RecipeEntity.toDomain(recipe);
  }

  @override
  Future<List<RecipeEntity>> getAllRecipes() async {
    final recipes = await _recipeDataSourceContract.getAllRecipes();

    return recipes
        .map(
          (e) => RecipeEntity.toDomain(e),
        )
        .toList();
  }

  @override
  Future<RecipeEntity?> updateRecipe(RecipeEntity recipe) async {
    final result =
        await _recipeDataSourceContract.updateRecipe(recipe.toDataModel());

    return RecipeEntity.toDomain(result);
  }

  @override
  Future<bool> deleteRecipe(int id) async {
    final result = await _recipeDataSourceContract.deleteRecipe(id);

    return result == 1 ? true : false;
  }
}
