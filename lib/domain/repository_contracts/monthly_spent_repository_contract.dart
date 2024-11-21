import 'package:nutri_teca/domain/models/monthly_spent_entity.dart';

abstract class MonthlySpentRepositoryContract {
  Future<MonthlySpentEntity?> createMonthlySpent(
      MonthlySpentEntity monthlySpent);
  Future<List<MonthlySpentEntity>> getAllMonthlySpent();
  Future<int> deleteMonthlySpent(int id);
  Future<bool> deleteSpentIfNewMonth();
}
