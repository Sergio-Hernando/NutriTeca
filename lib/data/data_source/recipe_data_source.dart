import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/data/models/recipe_remote_entity.dart';
import 'package:food_macros/data/repositories/data_source_contracts/recipe_data_source_contract.dart';

class RecipeDataSource implements RecipeDataSourceContract {
  final DatabaseHandler dbHandler;

  RecipeDataSource({required this.dbHandler});

  @override
  Future<int> createRecipe(RecipeRemoteEntity recipe) async {
    final db = await dbHandler.database;
    return db.insert('receta', recipe.toMap());
  }

  @override
  Future<RecipeRemoteEntity?> getRecipe(int id) async {
    final db = await dbHandler.database;
    final maps = await db.query(
      'receta',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RecipeRemoteEntity.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<RecipeRemoteEntity>> getAllRecipes() async {
    final db = await dbHandler.database;
    final maps = await db.query('receta');

    return maps.map((map) => RecipeRemoteEntity.fromMap(map)).toList();
  }

  @override
  Future<int> updateRecipe(RecipeRemoteEntity recipe) async {
    final db = await dbHandler.database;
    return db.update(
      'receta',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  @override
  Future<int> deleteRecipe(int id) async {
    final db = await dbHandler.database;
    return db.delete(
      'receta',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
