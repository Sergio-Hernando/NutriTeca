import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/data/models/ingredients_recipe_remote_entity.dart';
import 'package:food_macros/data/data_source_contracts/ingredients_recipe_data_source_contract.dart';

class IngredientsRecipeDataSource
    implements IngredientsRecipeDataSourceContract {
  final DatabaseHandler dbHandler;

  IngredientsRecipeDataSource({required this.dbHandler});

  @override
  Future<int> createIngredientsRecipe(
      IngredientsRecipeRemoteEntity entity) async {
    final db = await dbHandler.database;
    return db.insert('recipe_aliment', entity.toMap());
  }

  @override
  Future<IngredientsRecipeRemoteEntity?> getIngredientsRecipe(int id) async {
    final db = await dbHandler.database;
    final maps = await db.query(
      'recipe_aliment',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return IngredientsRecipeRemoteEntity.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<IngredientsRecipeRemoteEntity>> getAllIngredientsRecipe() async {
    final db = await dbHandler.database;
    final maps = await db.query('recipe_aliment');

    return maps
        .map((map) => IngredientsRecipeRemoteEntity.fromMap(map))
        .toList();
  }

  @override
  Future<int> updateIngredientsRecipe(
      IngredientsRecipeRemoteEntity entity) async {
    final db = await dbHandler.database;
    return db.update(
      'recipe_aliment',
      entity.toMap(),
      where: 'id = ?',
      whereArgs: [entity.id],
    );
  }

  @override
  Future<int> deleteIngredientsRecipe(int id) async {
    final db = await dbHandler.database;
    return db.delete(
      'recipe_aliment',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
