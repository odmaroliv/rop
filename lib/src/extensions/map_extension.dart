import '../result.dart';

extension MapExtension<T extends Object> on Result<T> {
  Result<U> map<U>(U Function(T) mapper) {
    if (isSuccess && value != null) {
      return Result.success(mapper(value!));
    }
    return Result.failure(errors);
  }

  Future<Result<U>> mapAsync<U>(Future<U> Function(T) mapper) async {
    if (isSuccess && value != null) {
      return Result.success(await mapper(value!));
    }
    return Result.failure(errors);
  }
}
