import 'package:food_macros/data/models/ingredients_recipe_data_entity.dart';
import 'package:food_macros/data/data_source_contracts/ingredients_recipe_data_source_contract.dart';

class IngredientsRecipeRepository {
  final IngredientsRecipeDataSourceContract
      _ingredientsRecipeDataSourceContract;

  IngredientsRecipeRepository(this._ingredientsRecipeDataSourceContract);

  Future<void> createIngredientsRecipe(
      int recipeId, Map<int, int> alimentsConCantidades) async {
    // `alimentsConCantidades` es un mapa donde la clave es el `id` del aliment y el valor es la quantity.

    for (final entry in alimentsConCantidades.entries) {
      final alimentId = entry.key;
      final quantity = entry.value;

      final relacion = IngredientsRecipeDataEntity(
        idAlimento: alimentId,
        idReceta: recipeId,
        quantity: quantity,
      );

      await _ingredientsRecipeDataSourceContract
          .createIngredientsRecipe(relacion);
    }
  }

  /* @override
  Future<AlimentEntity?> getAliment(int id) async {
    final data = await _alimentDataSourceContract.getAliment(id);

    return data?.toEntity();
  }

  @override
  Future<List<AlimentEntity>> getAllAliments() async {
    final data = await _alimentDataSourceContract.getAllAliments();

    final response = data
        .map(
          (e) => e.toEntity(),
        )
        .toList();

    return response;
  }

  @override
  Future<int> updateAliment(AlimentRequestEntity aliment) async {
    final data = await _alimentDataSourceContract
        .updateAliment(aliment.toRemoteEntity());

    return data;
  }

  @override
  Future<int> deleteAliment(int id) async {
    final data = await _alimentDataSourceContract.deleteAliment(id);

    return data;
  } */
}
