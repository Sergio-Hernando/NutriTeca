import 'package:food_macros/data/models/ingredients_recipe_data_entity.dart';

abstract class IngredientsRecipeDataSourceContract {
  Future<int> createIngredientsRecipe(IngredientsRecipeDataEntity entity);
  Future<IngredientsRecipeDataEntity?> getIngredientsRecipe(int id);
  Future<List<IngredientsRecipeDataEntity>> getAllIngredientsRecipe();
  Future<int> updateIngredientsRecipe(IngredientsRecipeDataEntity entity);
  Future<int> deleteIngredientsRecipe(int id);
}
