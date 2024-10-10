class MonthlySpentDataEntity {
  final int? id;
  final int idAlimento;
  final String date;
  final double quantity;

  MonthlySpentDataEntity({
    this.id,
    required this.idAlimento,
    required this.date,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_aliment': idAlimento,
      'date': date,
      'quantity': quantity,
    };
  }

  factory MonthlySpentDataEntity.fromMap(Map<String, dynamic> map) {
    return MonthlySpentDataEntity(
      id: map['id'],
      idAlimento: map['id_aliment'],
      date: map['date'],
      quantity: map['quantity'],
    );
  }
}
