import 'package:nutri_teca/data/data_source/remote_data_source/api/monthly_spent_api.dart';
import 'package:nutri_teca/data/data_source_contracts/monthly_spent_data_source_contract.dart';
import 'package:nutri_teca/data/models/monthly_spent_data_entity.dart';

class MonthlySpentRemoteDataSource implements MonthlySpentDataSourceContract {
  final MonthlySpentApi _api;

  MonthlySpentRemoteDataSource(this._api);

  @override
  Future<MonthlySpentDataEntity?> createMonthlySpent(
          MonthlySpentDataEntity monthlySpent) async =>
      await _api.createMonthlySpent(monthlySpent: monthlySpent);

  @override
  Future<int> deleteMonthlySpent(int id) async =>
      await _api.deleteMonthlySpent(id: id.toString());
  @override
  Future<List<MonthlySpentDataEntity>> getAllMonthlySpent() async =>
      await _api.getAllMonthlySpent();

  @override
  Future<int> deleteSpentIfNewMonth() async =>
      await _api.deleteSpentIfNewMonth();
}
