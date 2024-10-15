import 'package:food_macros/domain/models/additive_entity.dart';

abstract class AdditiveRepositoryContract {
  Future<List<AdditiveEntity>> getAdditives();
}
