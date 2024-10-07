import 'package:food_macros/data/models/aliment_remote_entity.dart';

class RecipeRemoteEntity {
  final int id;
  final String name;
  final List<AlimentRemoteEntity> aliments;

  RecipeRemoteEntity({
    required this.id,
    required this.name,
    required this.aliments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory RecipeRemoteEntity.fromMap(Map<String, dynamic> map) {
    return RecipeRemoteEntity(
      id: map['id'],
      name: map['name'],
      aliments: map['aliments'],
    );
  }
}
