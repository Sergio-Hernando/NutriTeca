import 'package:food_macros/data/models/aliment_remote_entity.dart';

abstract class AlimentDataSourceContract {
  Future<int> createAliment(AlimentRemoteEntity aliment);
  Future<AlimentRemoteEntity?> getAliment(int id);
  Future<List<AlimentRemoteEntity>> getAllAliments();
  Future<int> updateAliment(AlimentRemoteEntity aliment);
  Future<int> deleteAliment(int id);
}
