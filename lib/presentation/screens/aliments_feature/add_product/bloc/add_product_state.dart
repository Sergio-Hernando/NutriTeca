import 'package:food_macros/core/types/screen_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    required ScreenStatus screenStatus,
  }) = _AddProductState;

  factory AddProductState.initial() {
    return const AddProductState(screenStatus: ScreenStatus.initial());
  }
}
