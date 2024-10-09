import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/domain/models/request/recipe_request_entity.dart';

abstract class RecipeRepositoryContract {
  Future<RecipeEntity?> createRecipe(RecipeRequestEntity aliment);
  Future<RecipeEntity?> getRecipe(int id);
  Future<List<RecipeEntity>> getAllRecipes();
  Future<bool> updateRecipe(RecipeRequestEntity aliment);
  Future<bool> deleteRecipe(int id);
}
