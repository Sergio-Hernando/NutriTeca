class MonthlySpentDataEntity {
  final int? id;
  final int alimentId;
  final String alimentName;
  final String date;
  final int quantity;

  MonthlySpentDataEntity({
    this.id,
    required this.alimentId,
    required this.alimentName,
    required this.date,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_aliment': alimentId,
      'aliment_name': alimentName,
      'date': date,
      'quantity': quantity,
    };
  }

  factory MonthlySpentDataEntity.fromMap(Map<String, dynamic> map) {
    return MonthlySpentDataEntity(
      id: map['id'],
      alimentId: map['id_aliment'],
      alimentName: map['aliment_name'],
      date: map['date'],
      quantity: map['quantity'],
    );
  }
}
