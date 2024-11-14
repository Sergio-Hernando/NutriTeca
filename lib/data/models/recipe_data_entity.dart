import 'package:nutri_teca/data/models/aliment_data_entity.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'instructions': instructions,
    };
  }

  Map<String, dynamic> alimentstoJson(int recipeId, AlimentDataEntity aliment) {
    return {
      'id_recipe': recipeId,
      'id_aliment': aliment.id,
      'quantity': aliment.quantity,
    };
  }

  factory RecipeDataEntity.fromJson(Map<String, dynamic> map) {
    return RecipeDataEntity(
      id: map['id'],
      name: map['name'],
      instructions: map['instructions'],
      aliments: map['aliments'],
    );
  }
}
