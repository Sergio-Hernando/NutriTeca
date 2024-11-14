import 'package:nutri_teca/core/database/database_handler.dart';
import 'package:nutri_teca/data/models/monthly_spent_data_entity.dart';
import 'package:nutri_teca/data/data_source_contracts/monthly_spent_data_source_contract.dart';

class MonthlySpentDataSource implements MonthlySpentDataSourceContract {
  final DatabaseHandler dbHandler;

  MonthlySpentDataSource({required this.dbHandler});

  @override
  Future<MonthlySpentDataEntity?> createMonthlySpent(
      MonthlySpentDataEntity monthlySpent) async {
    final db = await dbHandler.database;
    final id = await db.insert('spent', monthlySpent.toJson());
    return getMonthlySpent(id);
  }

  Future<MonthlySpentDataEntity?> getMonthlySpent(int id) async {
    final db = await dbHandler.database;
    final maps = await db.query(
      'spent',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MonthlySpentDataEntity.fromJson(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<MonthlySpentDataEntity>> getAllMonthlySpent() async {
    final db = await dbHandler.database;
    final maps = await db.query('spent');

    return maps.map((map) => MonthlySpentDataEntity.fromJson(map)).toList();
  }

  @override
  Future<int> deleteMonthlySpent(int id) async {
    final db = await dbHandler.database;

    return await db.delete(
      'spent',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteSpentIfNewMonth() async {
    var result = 0;
    final DateTime now = DateTime.now();
    if (now.day == 1) {
      final db = await dbHandler.database;
      result = await db.delete('spent');
    }

    return result;
  }
}
