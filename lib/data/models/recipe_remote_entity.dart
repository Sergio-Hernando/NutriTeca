import 'package:food_macros/data/models/aliment_remote_entity.dart';

class RecipeRemoteEntity {
  final int id;
  final String name;
  final String instructions;
  final List<AlimentRemoteEntity>? aliments;

  RecipeRemoteEntity({
    required this.id,
    required this.name,
    required this.instructions,
    this.aliments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'instructions': instructions,
    };
  }

  factory RecipeRemoteEntity.fromMap(Map<String, dynamic> map) {
    return RecipeRemoteEntity(
      id: map['id'],
      name: map['name'],
      instructions: map['instructions'],
      aliments: map['aliments'],
    );
  }
}
