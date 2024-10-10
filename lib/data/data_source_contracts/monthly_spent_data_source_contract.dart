import 'package:food_macros/data/models/monthly_spent_data_entity.dart';

abstract class MonthlySpentDataSourceContract {
  Future<int> createMonthlySpent(MonthlySpentDataEntity monthlySpent);
  Future<MonthlySpentDataEntity?> getMonthlySpent(int id);
  Future<List<MonthlySpentDataEntity>> getAllMonthlySpents();
  Future<int> updateMonthlySpent(MonthlySpentDataEntity monthlySpent);
  Future<int> deleteMonthlySpent(int id);
}
