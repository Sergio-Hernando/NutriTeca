import 'package:food_macros/data/models/recipe_remote_entity.dart';

abstract class RecipeDataSourceContract {
  Future<int> createRecipe(RecipeRemoteEntity recipe);
  Future<RecipeRemoteEntity?> getRecipe(int id);
  Future<List<RecipeRemoteEntity>> getAllRecipes();
  Future<int> updateRecipe(RecipeRemoteEntity recipe);
  Future<int> deleteRecipe(int id);
}
