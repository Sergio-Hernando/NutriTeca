import 'package:food_macros/data/models/aliment_remote_entity.dart';

class AlimentRequestEntity {
  final int? id;
  final String name;
  final String imageBase64;
  final String supermarket;
  final int calories;

  final int fats;
  final int? fatsSaturated;
  final int? fatsPolyunsaturated;
  final int? fatsMonounsaturated;
  final int? fatsTrans;

  final int carbohydrates;
  final int? fiber;
  final int? sugar;

  final int proteins;

  final int? salt;

  AlimentRequestEntity({
    this.id,
    required this.name,
    required this.imageBase64,
    required this.supermarket,
    required this.calories,
    required this.fats,
    this.fatsSaturated,
    this.fatsPolyunsaturated,
    this.fatsMonounsaturated,
    this.fatsTrans,
    required this.carbohydrates,
    this.fiber,
    this.sugar,
    required this.proteins,
    this.salt,
  });
}

extension AlimentRequestEntityExtension on AlimentRequestEntity {
  AlimentRemoteEntity toRemoteEntity() => AlimentRemoteEntity(
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
      salt: salt);
}
