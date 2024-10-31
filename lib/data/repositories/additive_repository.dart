import 'package:nutri_teca/data/data_source_contracts/additives_data_source_contract.dart';
import 'package:nutri_teca/domain/models/additive_entity.dart';
import 'package:nutri_teca/domain/repository_contracts/additive_repository_contract.dart';

class AdditiveRepository implements AdditiveRepositoryContract {
  final AdditivesDataSourceContract _additivesDataSourceContract;

  AdditiveRepository(this._additivesDataSourceContract);
  @override
  Future<List<AdditiveEntity>> getAdditives() async {
    final data = await _additivesDataSourceContract.getAdditives();

    final response = data
        .map(
          (e) => AdditiveEntity.toDomain(e),
        )
        .toList();

    return response;
  }
}
