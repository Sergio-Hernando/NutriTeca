import 'package:food_macros/data/data_source_contracts/monthly_spent_data_source_contract.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/domain/repository_contracts/monthly_spent_repository_contract.dart';

class MonthlySpentRepository implements MonthlySpentRepositoryContract {
  final MonthlySpentDataSourceContract _alimentDataSourceContract;

  MonthlySpentRepository(this._alimentDataSourceContract);

  @override
  Future<MonthlySpentEntity?> createMonthlySpent(
      MonthlySpentEntity aliment) async {
    final data = await _alimentDataSourceContract
        .createMonthlySpent(aliment.toDataModel());

    return MonthlySpentEntity.toDomain(data);
  }

  @override
  Future<MonthlySpentEntity?> getMonthlySpent(int id) async {
    final data = await _alimentDataSourceContract.getMonthlySpent(id);

    return MonthlySpentEntity.toDomain(data);
  }

  @override
  Future<List<MonthlySpentEntity>> getAllMonthlySpent() async {
    final data = await _alimentDataSourceContract.getAllMonthlySpent();

    final response = data
        .map(
          (e) => MonthlySpentEntity.toDomain(e),
        )
        .toList();

    return response;
  }

  @override
  Future<int> deleteMonthlySpent(int id) async {
    return await _alimentDataSourceContract.deleteMonthlySpent(id);
  }
}
