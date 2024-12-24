import '../result.dart';

class Tuple2<T, U> {
  final T item1;
  final U item2;

  Tuple2(this.item1, this.item2);
}

extension CombineExtension<T extends Object> on Result<T> {
  Result<Tuple2<T, U>> combine<U extends Object>(Result<U> other) {
    if (isSuccess && other.isSuccess) {
      return Result.success(Tuple2(value!, other.value!));
    }
    return Result.failure([...errors, ...other.errors]);
  }
}
