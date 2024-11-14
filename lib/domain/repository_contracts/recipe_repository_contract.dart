import 'package:nutri_teca/domain/models/recipe_entity.dart';

abstract class RecipeRepositoryContract {
  Future<RecipeEntity?> createRecipe(RecipeEntity aliment);
  Future<RecipeEntity?> getRecipe(int id);
  Future<List<RecipeEntity>> getAllRecipes();
  Future<List<RecipeEntity>> getRecipesByAlimentId(int alimentId);
  Future<RecipeEntity?> updateRecipe(RecipeEntity aliment);
  Future<bool> deleteRecipe(int id);
}
