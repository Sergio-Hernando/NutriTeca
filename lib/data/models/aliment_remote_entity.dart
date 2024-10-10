class AlimentRemoteEntity {
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
  final String? quantity;

  AlimentRemoteEntity({
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
    this.quantity,
  });

  factory AlimentRemoteEntity.fromMap(Map<String, dynamic> map) {
    return AlimentRemoteEntity(
      id: map['id'],
      name: map['name'],
      imageBase64: map['image_base64'],
      supermarket: map['supermarket'],
      calories: map['calories'],
      fats: map['fats'],
      fatsSaturated: map['fats_saturated'],
      fatsPolyunsaturated: map['fats_polyunsaturated'],
      fatsMonounsaturated: map['fats_monounsaturated'],
      fatsTrans: map['fats_trans'],
      carbohydrates: map['carbohydrates'],
      fiber: map['fiber'],
      sugar: map['sugar'],
      proteins: map['proteins'],
      salt: map['salt'],
    );
  }
}
