import 'package:food_macros/data/models/additives_data_entity.dart';

class AdditiveEntity {
  final int id;
  final String additiveNumber;
  final String name;
  final String description;

  AdditiveEntity({
    required this.id,
    required this.additiveNumber,
    required this.name,
    required this.description,
  });

  factory AdditiveEntity.toDomain(AdditiveDataEntity? dataEntity) {
    return AdditiveEntity(
        id: dataEntity?.id ?? 0,
        name: dataEntity?.name ?? '',
        additiveNumber: dataEntity?.additiveNumber ?? '',
        description: dataEntity?.description ?? '');
  }

  AdditiveDataEntity toDataModel() {
    return AdditiveDataEntity(
        id: id,
        name: name,
        additiveNumber: additiveNumber,
        description: description);
  }
}
