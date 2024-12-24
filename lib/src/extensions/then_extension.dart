import '../result.dart';

extension ThenExtension<T extends Object> on Result<T> {
  Result<T> then(void Function(T) action) {
    if (isSuccess) {
      action(value!);
    }
    return this;
  }

  Future<Result<T>> thenAsync(Future<void> Function(T) action) async {
    if (isSuccess) {
      await action(value!);
    }
    return this;
  }
}
