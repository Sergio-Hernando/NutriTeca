import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aliment_detail_event.freezed.dart';

@freezed
class AlimentDetailEvent with _$AlimentDetailEvent {
  const factory AlimentDetailEvent.deleteAliment(int alimentId) =
      _DeleteAliment;
  const factory AlimentDetailEvent.editAliment(AlimentEntity aliment) =
      _EditAliment;
}
