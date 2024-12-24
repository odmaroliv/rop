import 'package:rop/rop.dart';

extension FutureBindExtension<T extends Object> on Future<Result<T>> {
  Future<Result<U>> bindAsync<U>(Future<Result<U>> Function(T) fn) async {
    final result = await this;
    if (result.isSuccess && result.value != null) {
      return await fn(result.value!);
    }
    return Result.failure(result.errors);
  }
}
