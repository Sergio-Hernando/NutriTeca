import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/data/models/aliment_remote_entity.dart';
import 'package:food_macros/data/repositories/data_source_contracts/aliment_data_source_contract.dart';

class AlimentDataSource implements AlimentDataSourceContract {
  final DatabaseHandler dbHandler;

  AlimentDataSource({required this.dbHandler});

  @override
  Future<int> createAliment(AlimentRemoteEntity aliment) async {
    final db = await dbHandler.database;
    return db.insert('aliment', aliment.toMap());
  }

  @override
  Future<AlimentRemoteEntity?> getAliment(int id) async {
    final db = await dbHandler.database;
    final maps = await db.query(
      'aliment',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AlimentRemoteEntity.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<AlimentRemoteEntity>> getAllAliments() async {
    final db = await dbHandler.database;
    final maps = await db.query('aliment');

    return maps.map((map) => AlimentRemoteEntity.fromMap(map)).toList();
  }

  @override
  Future<int> updateAliment(AlimentRemoteEntity aliment) async {
    final db = await dbHandler.database;
    return db.update(
      'aliment',
      aliment.toMap(),
      where: 'id = ?',
      whereArgs: [aliment.id],
    );
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
