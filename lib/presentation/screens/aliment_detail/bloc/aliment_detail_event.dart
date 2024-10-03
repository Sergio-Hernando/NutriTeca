import 'package:freezed_annotation/freezed_annotation.dart';

part 'aliment_detail_event.freezed.dart';

@freezed
class AlimentDetailEvent with _$AlimentDetailEvent {
  const factory AlimentDetailEvent.deleteAliment(int alimentId) =
      _DeleteAliment;
}
