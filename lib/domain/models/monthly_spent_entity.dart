import 'package:nutri_teca/data/models/monthly_spent_data_entity.dart';

class MonthlySpentEntity {
  final int? id;
  final int alimentId;
  final String alimentName;
  final String date;
  final int quantity;

  MonthlySpentEntity({
    this.id,
    required this.alimentId,
    required this.alimentName,
    required this.date,
    required this.quantity,
  });

  factory MonthlySpentEntity.toDomain(MonthlySpentDataEntity? dataEntity) {
    return MonthlySpentEntity(
        id: dataEntity?.id,
        alimentId: dataEntity?.alimentId ?? 0,
        alimentName: dataEntity?.alimentName ?? '',
        date: dataEntity?.date ?? '',
        quantity: dataEntity?.quantity ?? 0);
  }

  MonthlySpentDataEntity toDataModel() {
    return MonthlySpentDataEntity(
        id: id,
        alimentId: alimentId,
        alimentName: alimentName,
        date: date,
        quantity: quantity);
  }
}
