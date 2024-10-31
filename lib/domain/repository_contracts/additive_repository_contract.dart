import 'package:nutri_teca/domain/models/additive_entity.dart';

abstract class AdditiveRepositoryContract {
  Future<List<AdditiveEntity>> getAdditives();
}
