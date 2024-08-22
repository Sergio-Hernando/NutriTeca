class RecipeRemoteEntity {
  final int? id;
  final String name;

  RecipeRemoteEntity({this.id, required this.name});

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
    );
  }
}
