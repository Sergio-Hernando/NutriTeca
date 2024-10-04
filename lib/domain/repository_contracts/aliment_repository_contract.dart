import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';

abstract class AlimentRepositoryContract {
  Future<int> createAliment(AlimentRequestEntity aliment);
  Future<AlimentEntity?> getAliment(int id);
  Future<List<AlimentEntity>> getAllAliments();
  Future<int> updateAliment(AlimentRequestEntity aliment);
  Future<bool> deleteAliment(int id);
}
