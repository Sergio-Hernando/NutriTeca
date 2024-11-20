import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.unSplashInMilliseconds(int milliseconds) =
      _UnSplashInMilliseconds;
  const factory SplashEvent.getUserId() = _GetUserId;
}
