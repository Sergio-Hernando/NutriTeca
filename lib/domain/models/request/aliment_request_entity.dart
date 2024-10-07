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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image_base64': imageBase64,
      'supermarket': supermarket,
      'calories': calories,
      'fats': fats,
      'fats_saturated': fatsSaturated,
      'fats_polyunsaturated': fatsPolyunsaturated,
      'fats_monounsaturated': fatsMonounsaturated,
      'fats_trans': fatsTrans,
      'carbohydrates': carbohydrates,
      'fiber': fiber,
      'sugar': sugar,
      'proteins': proteins,
      'salt': salt,
    };
  }
}
