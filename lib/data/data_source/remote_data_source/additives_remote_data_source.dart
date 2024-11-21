import 'package:nutri_teca/data/data_source/remote_data_source/api/additives_api.dart';
import 'package:nutri_teca/data/data_source_contracts/additives_data_source_contract.dart';
import 'package:nutri_teca/data/models/additives_data_entity.dart';

class AdditiveRemoteDataSource implements AdditivesDataSourceContract {
  final AdditivesApi _api;

  AdditiveRemoteDataSource(this._api);

  @override
  Future<List<AdditiveDataEntity>> getAdditives() async =>
      await _api.getAdditives();
}
