import 'package:food_macros/data/models/ingredients_recipe_remote_entity.dart';

abstract class IngredientsRecipeDataSourceContract {
  Future<int> createIngredientsRecipe(IngredientsRecipeRemoteEntity entity);
  Future<IngredientsRecipeRemoteEntity?> getIngredientsRecipe(int id);
  Future<List<IngredientsRecipeRemoteEntity>> getAllIngredientsRecipe();
  Future<int> updateIngredientsRecipe(IngredientsRecipeRemoteEntity entity);
  Future<int> deleteIngredientsRecipe(int id);
}
