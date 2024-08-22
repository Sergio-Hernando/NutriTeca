import 'package:food_macros/data/repositories/data_source_contracts/aliment_data_source_contract.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';

class AlimentRepository implements AlimentRepositoryContract {
  final AlimentDataSourceContract _alimentDataSourceContract;

  AlimentRepository(this._alimentDataSourceContract);

  @override
  Future<int> createAliment(AlimentRequestEntity aliment) async {
    final data = await _alimentDataSourceContract
        .createAliment(aliment.toRemoteEntity());

    return data;
  }

  @override
  Future<AlimentEntity?> getAliment(int id) async {
    final data = await _alimentDataSourceContract.getAliment(id);

    return data?.toEntity();
  }

  @override
  Future<List<AlimentEntity>> getAllAliments() async {
    final data = await _alimentDataSourceContract.getAllAliments();

    final response = data
        .map(
          (e) => e.toEntity(),
        )
        .toList();

    return response;
  }

  @override
  Future<int> updateAliment(AlimentRequestEntity aliment) async {
    final data = await _alimentDataSourceContract
        .updateAliment(aliment.toRemoteEntity());

    return data;
  }

  @override
  Future<int> deleteAliment(int id) async {
    final data = await _alimentDataSourceContract.deleteAliment(id);

    return data;
  }
}
