import 'package:food_macros/data/models/monthly_spent_remote_entity.dart';

abstract class MonthlySpentDataSourceContract {
  Future<int> createMonthlySpent(MonthlySpentRemoteEntity monthlySpent);
  Future<MonthlySpentRemoteEntity?> getMonthlySpent(int id);
  Future<List<MonthlySpentRemoteEntity>> getAllMonthlySpents();
  Future<int> updateMonthlySpent(MonthlySpentRemoteEntity monthlySpent);
  Future<int> deleteMonthlySpent(int id);
}
