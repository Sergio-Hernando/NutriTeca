class RecipeRemoteEntity {
  final int? id;
  final String nombre;

  RecipeRemoteEntity({this.id, required this.nombre});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory RecipeRemoteEntity.fromMap(Map<String, dynamic> map) {
    return RecipeRemoteEntity(
      id: map['id'],
      nombre: map['nombre'],
    );
  }
}
