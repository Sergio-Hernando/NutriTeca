import 'package:nutri_teca/data/models/additives_data_entity.dart';

abstract class AdditivesDataSourceContract {
  Future<List<AdditiveDataEntity>> getAdditives();
}
