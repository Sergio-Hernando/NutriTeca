import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/data/models/aliment_remote_entity.dart';
import 'package:food_macros/data/models/recipe_remote_entity.dart';
import 'package:food_macros/data/data_source_contracts/recipe_data_source_contract.dart';
import 'package:food_macros/domain/models/request/recipe_request_entity.dart';

class RecipeDataSource implements RecipeDataSourceContract {
  final DatabaseHandler dbHandler;

  RecipeDataSource({required this.dbHandler});

  @override
  Future<int> createRecipe(RecipeRequestEntity recipe) async {
    final db = await dbHandler.database;

    final result = await db.transaction((txn) async {
      final recipeId = await txn.insert('recipe', recipe.toMap());

      for (var aliment in recipe.aliments) {
        await txn.insert('recipe_aliment',
            recipe.alimentsToMap(recipeId, aliment) as Map<String, Object?>);
      }
    });

    return result;
  }

  @override
  Future<RecipeRemoteEntity?> getRecipe(int id) async {
    final db = await dbHandler.database;

    final recipeMaps = await db.query(
      'recipe',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (recipeMaps.isNotEmpty) {
      final recipeName = recipeMaps.first['name'];

      final alimentMaps = await db.query(
        'recipe_aliment',
        where: 'id_recipe = ?',
        whereArgs: [id],
      );

      List<AlimentRemoteEntity> aliments = [];

      for (var alimentMap in alimentMaps) {
        final alimentId = alimentMap['id_aliment'];

        final alimentInfo = await db.query(
          'aliment',
          where: 'id = ?',
          whereArgs: [alimentId],
        );

        if (alimentInfo.isNotEmpty) {
          final alimentData = alimentInfo.first;

          aliments.add(AlimentRemoteEntity(
            id: alimentData['id'] as int?,
            name: alimentData['name'] as String,
            imageBase64: alimentData['image_base64'] as String,
            supermarket: alimentData['supermarket'] as String,
            calories: alimentData['calories'] as int,
            fats: alimentData['fats'] as int,
            fatsSaturated: alimentData['fats_saturated'] as int?,
            fatsPolyunsaturated: alimentData['fats_polyunsaturated'] as int?,
            fatsMonounsaturated: alimentData['fats_monounsaturated'] as int?,
            fatsTrans: alimentData['fats_trans'] as int?,
            carbohydrates: alimentData['carbohydrates'] as int,
            fiber: alimentData['fiber'] as int?,
            sugar: alimentData['sugar'] as int?,
            proteins: alimentData['proteins'] as int,
            salt: alimentData['salt'] as int?,
            quantity: alimentMap['quantity'] as String?,
          ));
        }
      }

      return RecipeRemoteEntity(
        id: recipeMaps.first['id'] as int,
        name: recipeName as String,
        instructions: recipeMaps.first['instructions'] as String,
        aliments: aliments,
      );
    } else {
      return null;
    }
  }

  @override
  Future<List<RecipeRemoteEntity>> getAllRecipes() async {
    final db = await dbHandler.database;

    final recipeMaps = await db.query(
      'recipe',
      columns: ['id', 'name', 'instructions'],
    );

    List<RecipeRemoteEntity> recipes = [];

    for (var recipeMap in recipeMaps) {
      recipes.add(RecipeRemoteEntity(
        id: recipeMap['id'] as int,
        name: recipeMap['name'] as String,
        instructions: recipeMap['instructions'] as String,
        aliments: [],
      ));
    }

    return recipes;
  }

  @override
  Future<int> updateRecipe(RecipeRequestEntity updatedRecipe) async {
    final db = await dbHandler.database;

    // Empezamos una transacción
    final result = await db.transaction((txn) async {
      // 1. Actualizar el nombre de la receta si ha cambiado
      if (updatedRecipe.name.isNotEmpty) {
        await txn.update(
          'recipe',
          {'name': updatedRecipe.name},
          where: 'id = ?',
          whereArgs: [updatedRecipe.id],
        );
      }

      // 2. Obtener los alimentos actuales de la receta
      final existingAliments = await txn.query(
        'recipe_aliment',
        where: 'id_recipe = ?',
        whereArgs: [updatedRecipe.id],
      );

      // 3. Borrar los alimentos que ya no están en la receta actualizada
      for (var existingAliment in existingAliments) {
        final existingAlimentId = existingAliment['id_aliment'];

        // Verificar si el alimento sigue en la receta actualizada
        final alimentExistsInUpdatedRecipe = updatedRecipe.aliments.any(
          (updatedAliment) => updatedAliment.entries.first == existingAlimentId,
        );

        // Si no existe, lo borramos
        if (!alimentExistsInUpdatedRecipe) {
          await txn.delete(
            'recipe_aliment',
            where: 'id_aliment = ? AND id_recipe = ?',
            whereArgs: [existingAlimentId, updatedRecipe.id],
          );
        }
      }

      // 4. Actualizar o agregar los alimentos nuevos
      for (var updatedAliment in updatedRecipe.aliments) {
        final existingAliment = existingAliments.firstWhere(
          (element) => element['id_aliment'] == updatedAliment.entries.first,
          orElse: () => <String, Object?>{},
        );

        if (existingAliment.isNotEmpty) {
          // Si el alimento ya existe, actualizamos la cantidad
          if (updatedAliment.values.first != null) {
            await txn.update(
              'recipe_aliment',
              {'quantity': updatedAliment.values.first},
              where: 'id_aliment = ? AND id_recipe = ?',
              whereArgs: [updatedAliment.entries.first, updatedRecipe.id],
            );
          }
        } else {
          // Si es un nuevo alimento, lo agregamos
          await txn.insert('recipe_aliment', {
            'id_recipe': updatedRecipe.id,
            'id_aliment': updatedAliment.entries.first,
            'quantity': updatedAliment.values.first ?? 1,
          });
        }
      }
    });

    return result;
  }

  @override
  Future<int> deleteRecipe(int id) async {
    final db = await dbHandler.database;

    final result = await db.transaction((txn) async {
      // 1. Borrar la receta de la tabla 'recipe'
      await txn.delete(
        'recipe',
        where: 'id = ?',
        whereArgs: [id],
      );

      // 2. Borrar todos los alimentos asociados de la tabla 'recipe_aliment'
      // Aunque el 'ON DELETE CASCADE' en la tabla 'recipe_aliment' debería eliminar automáticamente
      // los registros relacionados, es una buena práctica asegurarse de hacerlo manualmente en caso
      // de que las restricciones cambien o para tener control explícito.
      await txn.delete(
        'recipe_aliment',
        where: 'id_recipe = ?',
        whereArgs: [id],
      );
    });

    return result;
  }
}
