import 'package:nutri_teca/data/models/recipe_data_entity.dart';

abstract class RecipeDataSourceContract {
  Future<RecipeDataEntity?> createRecipe(RecipeDataEntity recipe);
  Future<RecipeDataEntity?> getRecipe(int id);
  Future<List<RecipeDataEntity>> getAllRecipes();
  Future<List<RecipeDataEntity>> getRecipesById(int id);
  Future<RecipeDataEntity?> updateRecipe(RecipeDataEntity recipe);
  Future<int> deleteRecipe(int id);
}
