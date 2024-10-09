import 'package:food_macros/data/models/aliment_remote_entity.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';

abstract class AlimentDataSourceContract {
  Future<AlimentRemoteEntity?> createAliment(AlimentRequestEntity aliment);
  Future<AlimentRemoteEntity?> getAliment(int id);
  Future<List<AlimentRemoteEntity>> getAllAliments();
  Future<int> updateAliment(AlimentRequestEntity aliment);
  Future<int> deleteAliment(int id);
}
