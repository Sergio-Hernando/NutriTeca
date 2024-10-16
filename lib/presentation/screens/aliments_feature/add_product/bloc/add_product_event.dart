import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_event.freezed.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.addProduct(AlimentEntity aliment) =
      _AddProductEvent;
}
