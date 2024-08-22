class MonthlySpentRemoteEntity {
  final int? id;
  final int idAlimento;
  final String date;
  final double quantity;

  MonthlySpentRemoteEntity({
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

  factory MonthlySpentRemoteEntity.fromMap(Map<String, dynamic> map) {
    return MonthlySpentRemoteEntity(
      id: map['id'],
      idAlimento: map['id_aliment'],
      date: map['date'],
      quantity: map['quantity'],
    );
  }
}
