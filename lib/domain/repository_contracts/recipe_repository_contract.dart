import 'package:food_macros/domain/models/recipe_entity.dart';

abstract class RecipeRepositoryContract {
  Future<RecipeEntity?> createRecipe(RecipeEntity aliment);
  Future<RecipeEntity?> getRecipe(int id);
  Future<List<RecipeEntity>> getAllRecipes();
  Future<bool> updateRecipe(RecipeEntity aliment);
  Future<bool> deleteRecipe(int id);
}
