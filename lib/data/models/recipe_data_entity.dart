import 'package:food_macros/data/models/aliment_data_entity.dart';

class RecipeDataEntity {
  final int? id;
  final String? name;
  final String? instructions;
  final List<AlimentDataEntity>? aliments;

  RecipeDataEntity({
    this.id,
    this.name,
    this.instructions,
    this.aliments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'instructions': instructions,
    };
  }

  Map<String, dynamic> alimentsToMap(int recipeId, AlimentDataEntity aliment) {
    return {
      'id_recipe': recipeId,
      'id_aliment': aliment.id,
      'quantity': aliment.quantity,
    };
  }

  factory RecipeDataEntity.fromMap(Map<String, dynamic> map) {
    return RecipeDataEntity(
      id: map['id'],
      name: map['name'],
      instructions: map['instructions'],
      aliments: map['aliments'],
    );
  }
}
