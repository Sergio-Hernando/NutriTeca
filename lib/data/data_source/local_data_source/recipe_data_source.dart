import 'package:nutri_teca/core/database/database_handler.dart';
import 'package:nutri_teca/data/models/aliment_data_entity.dart';
import 'package:nutri_teca/data/models/recipe_data_entity.dart';
import 'package:nutri_teca/data/data_source_contracts/recipe_data_source_contract.dart';

class RecipeDataSource implements RecipeDataSourceContract {
  final DatabaseHandler dbHandler;

  RecipeDataSource({required this.dbHandler});

  @override
  Future<RecipeDataEntity?> createRecipe(RecipeDataEntity recipe) async {
    final db = await dbHandler.database;

    final result = await db.transaction((txn) async {
      final recipeId = await txn.insert('recipe', recipe.toJson());

      recipe.aliments?.forEach((element) async {
        await txn.insert(
          'recipe_aliment',
          recipe.alimentstoJson(recipeId, element) as Map<String, Object?>,
        );
      });

      final recipeQuery = await txn.query(
        'recipe',
        columns: ['id', 'name', 'instructions'],
        where: 'id = ?',
        whereArgs: [recipeId],
      );

      if (recipeQuery.isNotEmpty) {
        final recipeMap = recipeQuery.first;

        return RecipeDataEntity(
          id: recipeMap['id'] as int,
          name: recipeMap['name'] as String,
          instructions: recipeMap['instructions'] as String,
        );
      } else {
        return null;
      }
    });

    return result;
  }

  @override
  Future<RecipeDataEntity?> getRecipe(int id) async {
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

      List<AlimentDataEntity> aliments = [];

      for (var alimentMap in alimentMaps) {
        final alimentId = alimentMap['id_aliment'];

        final alimentInfo = await db.query(
          'aliment',
          where: 'id = ?',
          whereArgs: [alimentId],
        );

        if (alimentInfo.isNotEmpty) {
          final alimentData = alimentInfo.first;

          aliments.add(AlimentDataEntity(
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
            quantity: alimentMap['quantity'].toString() as String?,
          ));
        }
      }

      return RecipeDataEntity(
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
  Future<List<RecipeDataEntity>> getAllRecipes() async {
    final db = await dbHandler.database;

    final recipeMaps = await db.query(
      'recipe',
      columns: ['id', 'name', 'instructions'],
    );

    List<RecipeDataEntity> recipes = [];

    for (var recipeMap in recipeMaps) {
      recipes.add(RecipeDataEntity(
        id: recipeMap['id'] as int,
        name: recipeMap['name'] as String,
        instructions: recipeMap['instructions'] as String,
        aliments: [],
      ));
    }

    return recipes;
  }

  @override
  Future<List<RecipeDataEntity>> getRecipesByAlimentId(int alimentId) async {
    final db = await dbHandler.database;

    final List<Map<String, dynamic>> allRecipes =
        await db.query('recipe', columns: ['id', 'name']);

    final List<Map<String, dynamic>> allRecipeAliments =
        await db.query('recipe_aliment', columns: ['id_recipe', 'id_aliment']);

    List<RecipeDataEntity> recipes = [];

    for (var recipe in allRecipes) {
      if (allRecipeAliments.any((recipeAliment) =>
          recipeAliment['id_recipe'] == recipe['id'] &&
          recipeAliment['id_aliment'] == alimentId)) {
        recipes.add(RecipeDataEntity(
          id: recipe['id'] as int,
          name: recipe['name'] as String,
          instructions: '',
          aliments: [],
        ));
      }
    }

    return recipes;
  }

  @override
  Future<RecipeDataEntity?> updateRecipe(RecipeDataEntity updatedRecipe) async {
    final db = await dbHandler.database;

    // Empezamos una transacción
    await db.transaction((txn) async {
      // 1. Actualizar el nombre de la receta si ha cambiado
      if (updatedRecipe.name!.isNotEmpty) {
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
        final bool alimentExistsInUpdatedRecipe = updatedRecipe.aliments?.any(
              (updatedAliment) => updatedAliment.id == existingAlimentId,
            ) ??
            false;

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
      updatedRecipe.aliments?.forEach(
        (updatedAliment) async {
          final existingAliment = existingAliments.firstWhere(
            (element) => element['id_aliment'] == updatedAliment.id,
            orElse: () => <String, Object?>{},
          );

          if (existingAliment.isNotEmpty) {
            // Si el alimento ya existe, actualizamos la cantidad
            if (updatedAliment.id != null) {
              await txn.update(
                'recipe_aliment',
                {'quantity': updatedAliment.quantity},
                where: 'id_aliment = ? AND id_recipe = ?',
                whereArgs: [updatedAliment.id, updatedRecipe.id],
              );
            }
          } else {
            // Si es un nuevo alimento, lo agregamos
            await txn.insert('recipe_aliment', {
              'id_recipe': updatedRecipe.id,
              'id_aliment': updatedAliment.id,
              'quantity': updatedAliment.quantity ?? 1,
            });
          }
        },
      );
    });
    return getRecipe(updatedRecipe.id ?? 0);
  }

  @override
  Future<int> deleteRecipe(int id) async {
    final db = await dbHandler.database;

    final result = await db.transaction((txn) async {
      // 1. Borrar la receta de la tabla 'recipe'
      final rows = await txn.delete(
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
      return rows;
    });

    return result;
  }
}
