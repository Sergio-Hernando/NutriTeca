import 'package:nutri_teca/domain/models/aliment_entity.dart';

abstract class AlimentRepositoryContract {
  Future<AlimentEntity?> createAliment(AlimentEntity aliment);
  Future<AlimentEntity?> getAliment(int id);
  Future<List<AlimentEntity>> getAllAliments();
  Future<AlimentEntity?> updateAliment(AlimentEntity aliment);
  Future<bool> deleteAliment(int id);
}
