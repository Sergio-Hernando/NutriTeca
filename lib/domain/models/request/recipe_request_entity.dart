class RecipeRequestEntity {
  final String? id;
  final String name;
  final String instructions;
  final List<Map<String, dynamic>> aliments;

  RecipeRequestEntity({
    this.id,
    required this.name,
    required this.instructions,
    required this.aliments,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'instructions': instructions,
    };
  }

  Map<String, dynamic> alimentsToMap(
      int recipeId, Map<String, dynamic> aliment) {
    return {
      'id_recipe': recipeId,
      'id_aliment': aliment['id'],
      'quantity': aliment['quantity'],
    };
  }
}

class AlimentRecipeRequestEntity {
  final String idAliment;
  final String quantity;

  AlimentRecipeRequestEntity({
    required this.idAliment,
    required this.quantity,
  });
}
