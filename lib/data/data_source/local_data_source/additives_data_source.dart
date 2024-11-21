import 'package:nutri_teca/data/database_handler.dart';
import 'package:nutri_teca/data/data_source_contracts/additives_data_source_contract.dart';
import 'package:nutri_teca/data/models/additives_data_entity.dart';

class AdditiveDataSource implements AdditivesDataSourceContract {
  final DatabaseHandler dbHandler;

  AdditiveDataSource({required this.dbHandler});
  @override
  Future<List<AdditiveDataEntity>> getAdditives() async {
    final db = await dbHandler.database;
    final maps = await db.query('additives');

    return maps.map((map) => AdditiveDataEntity.fromJson(map)).toList();
  }
}
