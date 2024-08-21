class MonthlySpentRemoteEntity {
  final int? id;
  final int idAlimento;
  final String fecha;
  final double cantidad;

  MonthlySpentRemoteEntity({
    this.id,
    required this.idAlimento,
    required this.fecha,
    required this.cantidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_alimento': idAlimento,
      'fecha': fecha,
      'cantidad': cantidad,
    };
  }

  factory MonthlySpentRemoteEntity.fromMap(Map<String, dynamic> map) {
    return MonthlySpentRemoteEntity(
      id: map['id'],
      idAlimento: map['id_alimento'],
      fecha: map['fecha'],
      cantidad: map['cantidad'],
    );
  }
}
