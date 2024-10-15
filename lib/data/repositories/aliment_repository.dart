import 'package:food_macros/data/data_source_contracts/aliment_data_source_contract.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';

class AlimentRepository implements AlimentRepositoryContract {
  final AlimentDataSourceContract _alimentDataSourceContract;

  AlimentRepository(this._alimentDataSourceContract);

  @override
  Future<AlimentEntity?> createAliment(AlimentEntity aliment) async {
    final data =
        await _alimentDataSourceContract.createAliment(aliment.toDataModel());

    return AlimentEntity.toDomain(data);
  }

  @override
  Future<AlimentEntity?> getAliment(int id) async {
    final data = await _alimentDataSourceContract.getAliment(id);

    return AlimentEntity.toDomain(data);
  }

  @override
  Future<List<AlimentEntity>> getAllAliments() async {
    final data = await _alimentDataSourceContract.getAllAliments();

    final response = data
        .map(
          (e) => AlimentEntity.toDomain(e),
        )
        .toList();

    return response;
  }

  @override
  Future<AlimentEntity?> updateAliment(AlimentEntity aliment) async {
    final data =
        await _alimentDataSourceContract.updateAliment(aliment.toDataModel());

    return AlimentEntity.toDomain(data);
  }

  @override
  Future<bool> deleteAliment(int id) async {
    final data = await _alimentDataSourceContract.deleteAliment(id);

    return data == 1 ? true : false;
  }
}
