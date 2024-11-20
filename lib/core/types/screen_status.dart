import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_status.freezed.dart';

@freezed
class ScreenStatus with _$ScreenStatus {
  const factory ScreenStatus.initial() = _Initial;
  const factory ScreenStatus.loading() = _Loading;
  const factory ScreenStatus.success() = _Success;
  const factory ScreenStatus.error(String string) = _Error;
}

extension ScreenStatusExtension on ScreenStatus {
  bool isLoading() => maybeWhen(orElse: () => false, loading: () => true);
  bool isError() => maybeWhen(orElse: () => false, error: (e) => true);
  bool isSuccess() => maybeWhen(orElse: () => false, success: () => true);
}
