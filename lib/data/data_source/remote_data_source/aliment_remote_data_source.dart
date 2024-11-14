import 'package:nutri_teca/data/data_source/remote_data_source/api/aliment_api.dart';
import 'package:nutri_teca/data/data_source_contracts/aliment_data_source_contract.dart';
import 'package:nutri_teca/data/models/aliment_data_entity.dart';

class AlimentRemoteDataSource implements AlimentDataSourceContract {
  final AlimentApi _api;

  AlimentRemoteDataSource(this._api);

  @override
  Future<AlimentDataEntity?> createAliment(AlimentDataEntity aliment) async =>
      await _api.createAliment(aliment: aliment);

  @override
  Future<int> deleteAliment(int id) async =>
      await _api.deleteAliment(id: id.toString());

  @override
  Future<AlimentDataEntity> getAliment(int id) async =>
      await _api.getAliment(id: id.toString());

  @override
  Future<List<AlimentDataEntity>> getAllAliments() async =>
      await _api.getAllAliments();

  @override
  Future<AlimentDataEntity?> updateAliment(AlimentDataEntity aliment) async =>
      await _api.updateAliment(aliment: aliment);
}
