import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/data/models/monthly_spent_remote_entity.dart';
import 'package:food_macros/data/data_source_contracts/monthly_spent_data_source_contract.dart';

class MonthlySpentDataSource implements MonthlySpentDataSourceContract {
  final DatabaseHandler dbHandler;

  MonthlySpentDataSource({required this.dbHandler});

  @override
  Future<int> createMonthlySpent(MonthlySpentRemoteEntity monthlySpent) async {
    final db = await dbHandler.database;
    return db.insert('gasto', monthlySpent.toMap());
  }

  @override
  Future<MonthlySpentRemoteEntity?> getMonthlySpent(int id) async {
    final db = await dbHandler.database;
    final maps = await db.query(
      'gasto',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MonthlySpentRemoteEntity.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<MonthlySpentRemoteEntity>> getAllMonthlySpents() async {
    final db = await dbHandler.database;
    final maps = await db.query('gasto');

    return maps.map((map) => MonthlySpentRemoteEntity.fromMap(map)).toList();
  }

  @override
  Future<int> updateMonthlySpent(MonthlySpentRemoteEntity monthlySpent) async {
    final db = await dbHandler.database;
    return db.update(
      'gasto',
      monthlySpent.toMap(),
      where: 'id = ?',
      whereArgs: [monthlySpent.id],
    );
  }

  @override
  Future<int> deleteMonthlySpent(int id) async {
    final db = await dbHandler.database;
    return db.delete(
      'gasto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
