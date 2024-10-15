class AdditiveDataEntity {
  final int id;
  final String additiveNumber;
  final String name;
  final String description;

  AdditiveDataEntity({
    required this.id,
    required this.additiveNumber,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'additive_number': additiveNumber,
      'name': name,
      'description': description,
    };
  }

  factory AdditiveDataEntity.fromJson(Map<String, dynamic> json) {
    return AdditiveDataEntity(
      id: json['id'],
      additiveNumber: json['additive_number'],
      name: json['name'],
      description: json['description'],
    );
  }
}
