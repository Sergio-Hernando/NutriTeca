import 'package:nutri_teca/data/models/monthly_spent_data_entity.dart';

abstract class MonthlySpentDataSourceContract {
  Future<MonthlySpentDataEntity?> createMonthlySpent(
      MonthlySpentDataEntity monthlySpent);
  Future<MonthlySpentDataEntity?> getMonthlySpent(int id);
  Future<List<MonthlySpentDataEntity>> getAllMonthlySpent();
  Future<int> deleteMonthlySpent(int id);
  Future<bool> deleteSpentIfNewMonth();
}
