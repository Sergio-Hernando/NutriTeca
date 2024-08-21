class IngredientsRecipeRemoteEntity {
  final int? id;
  final int idAlimento;
  final int idReceta;
  final int cantidad;

  IngredientsRecipeRemoteEntity({
    this.id,
    required this.idAlimento,
    required this.idReceta,
    required this.cantidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_alimento': idAlimento,
      'id_receta': idReceta,
      'cantidad': cantidad,
    };
  }

  factory IngredientsRecipeRemoteEntity.fromMap(Map<String, dynamic> map) {
    return IngredientsRecipeRemoteEntity(
      id: map['id'],
      idAlimento: map['id_alimento'],
      idReceta: map['id_receta'],
      cantidad: map['cantidad'],
    );
  }
}
