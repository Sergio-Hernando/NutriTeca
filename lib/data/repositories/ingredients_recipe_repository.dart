import 'package:food_macros/data/models/ingredients_recipe_remote_entity.dart';
import 'package:food_macros/data/repositories/data_source_contracts/ingredients_recipe_data_source_contract.dart';

class IngredientsRecipeRepository {
  final IngredientsRecipeDataSourceContract
      _ingredientsRecipeDataSourceContract;

  IngredientsRecipeRepository(this._ingredientsRecipeDataSourceContract);

  Future<void> createIngredientsRecipe(
      int recetaId, Map<int, int> alimentosConCantidades) async {
    // `alimentosConCantidades` es un mapa donde la clave es el `id` del alimento y el valor es la cantidad.

    for (final entry in alimentosConCantidades.entries) {
      final alimentoId = entry.key;
      final cantidad = entry.value;

      final relacion = IngredientsRecipeRemoteEntity(
        idAlimento: alimentoId,
        idReceta: recetaId,
        cantidad: cantidad,
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
