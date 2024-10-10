import 'package:food_macros/data/models/aliment_data_entity.dart';

abstract class AlimentDataSourceContract {
  Future<AlimentDataEntity?> createAliment(AlimentDataEntity aliment);
  Future<AlimentDataEntity?> getAliment(int id);
  Future<List<AlimentDataEntity>> getAllAliments();
  Future<int> updateAliment(AlimentDataEntity aliment);
  Future<int> deleteAliment(int id);
}
