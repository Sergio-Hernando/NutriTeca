import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_aliment_event.freezed.dart';

@freezed
class AddAlimentEvent with _$AddAlimentEvent {
  const factory AddAlimentEvent.addAliment(AlimentEntity aliment) =
      _AddAlimentEvent;
}
