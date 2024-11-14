import 'package:nutri_teca/core/database/database_handler.dart';
import 'package:nutri_teca/data/models/aliment_data_entity.dart';
import 'package:nutri_teca/data/data_source_contracts/aliment_data_source_contract.dart';

class AlimentDataSource implements AlimentDataSourceContract {
  final DatabaseHandler dbHandler;

  AlimentDataSource({required this.dbHandler});

  @override
  Future<AlimentDataEntity?> createAliment(AlimentDataEntity aliment) async {
    final db = await dbHandler.database;
    final id = await db.insert('aliment', aliment.toJson());
    return getAliment(id);
  }

  @override
  Future<AlimentDataEntity?> getAliment(int id) async {
    final db = await dbHandler.database;
    final maps = await db.query(
      'aliment',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AlimentDataEntity.fromJson(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<AlimentDataEntity>> getAllAliments() async {
    final db = await dbHandler.database;
    final maps = await db.query('aliment');

    return maps.map((map) => AlimentDataEntity.fromJson(map)).toList();
  }

  @override
  Future<AlimentDataEntity?> updateAliment(AlimentDataEntity aliment) async {
    final db = await dbHandler.database;
    await db.update(
      'aliment',
      aliment.toJson(),
      where: 'id = ?',
      whereArgs: [aliment.id],
    );

    return getAliment(aliment.id ?? 0);
  }

  @override
  Future<int> deleteAliment(int id) async {
    final db = await dbHandler.database;
    return db.delete(
      'aliment',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
