class IngredientsRecipeDataEntity {
  final int? id;
  final int idAlimento;
  final int idReceta;
  final int quantity;

  IngredientsRecipeDataEntity({
    this.id,
    required this.idAlimento,
    required this.idReceta,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_aliment': idAlimento,
      'id_recipe': idReceta,
      'quantity': quantity,
    };
  }

  factory IngredientsRecipeDataEntity.fromMap(Map<String, dynamic> map) {
    return IngredientsRecipeDataEntity(
      id: map['id'],
      idAlimento: map['id_aliment'],
      idReceta: map['id_recipe'],
      quantity: map['quantity'],
    );
  }
}
