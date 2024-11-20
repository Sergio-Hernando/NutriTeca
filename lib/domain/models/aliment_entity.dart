import 'package:nutri_teca/data/models/aliment_data_entity.dart';

class AlimentEntity {
  final int? id;
  final String? name;
  final String? imageBase64;
  final String? supermarket;
  final int? calories;

  final int? fats;
  final int? fatsSaturated;
  final int? fatsPolyunsaturated;
  final int? fatsMonounsaturated;
  final int? fatsTrans;

  final int? carbohydrates;
  final int? fiber;
  final int? sugar;

  final int? proteins;

  final int? salt;
  String? quantity;

  AlimentEntity({
    this.id,
    this.name,
    this.imageBase64,
    this.supermarket,
    this.calories,
    this.fats,
    this.fatsSaturated,
    this.fatsPolyunsaturated,
    this.fatsMonounsaturated,
    this.fatsTrans,
    this.carbohydrates,
    this.fiber,
    this.sugar,
    this.proteins,
    this.salt,
    this.quantity,
  });

  factory AlimentEntity.toDomain(AlimentDataEntity? dataEntity) {
    return AlimentEntity(
        id: dataEntity?.id,
        name: dataEntity?.name ?? '',
        imageBase64: dataEntity?.imageBase64 ?? '',
        supermarket: dataEntity?.supermarket ?? '',
        calories: dataEntity?.calories ?? 0,
        fats: dataEntity?.fats ?? 0,
        fatsSaturated: dataEntity?.fatsSaturated,
        fatsPolyunsaturated: dataEntity?.fatsPolyunsaturated,
        fatsMonounsaturated: dataEntity?.fatsMonounsaturated,
        fatsTrans: dataEntity?.fatsTrans,
        carbohydrates: dataEntity?.carbohydrates ?? 0,
        fiber: dataEntity?.fiber,
        sugar: dataEntity?.sugar,
        proteins: dataEntity?.proteins ?? 0,
        salt: dataEntity?.salt,
        quantity: dataEntity?.quantity ?? '');
  }

  AlimentDataEntity toDataModel() {
    return AlimentDataEntity(
        id: id,
        name: name,
        imageBase64: imageBase64,
        supermarket: supermarket,
        calories: calories,
        fats: fats,
        fatsSaturated: fatsSaturated,
        fatsPolyunsaturated: fatsPolyunsaturated,
        fatsMonounsaturated: fatsMonounsaturated,
        fatsTrans: fatsTrans,
        carbohydrates: carbohydrates,
        fiber: fiber,
        sugar: sugar,
        proteins: proteins,
        salt: salt,
        quantity: quantity);
  }
}
