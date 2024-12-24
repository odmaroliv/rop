import 'package:rop/rop.dart';

extension BindExtension<T extends Object> on Result<T> {
  Result<U> bind<U>(Result<U> Function(T) fn) {
    if (isSuccess && value != null) {
      return fn(value!);
    }
    return Result.failure(errors);
  }

  Future<Result<U>> bindAsync<U>(Future<Result<U>> Function(T) fn) async {
    if (isSuccess && value != null) {
      return await fn(value!);
    }
    return Result.failure(errors);
  }
}
