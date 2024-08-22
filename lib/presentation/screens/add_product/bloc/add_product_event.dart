import 'package:food_macros/domain/models/request/aliment_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_event.freezed.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.addProduct(AlimentRequestEntity aliment) =
      _AddProductEvent;
}
