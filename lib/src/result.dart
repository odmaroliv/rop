import 'rop_error.dart';

class Result<T> {
  final T? value;
  final List<RopError> errors;
  final bool isSuccess;

  Result.success(this.value)
      : errors = const [],
        isSuccess = true {
    if (value == null) {
      throw ArgumentError('Value cannot be null in a success result.');
    }
  }

  Result.failure(this.errors)
      : value = null,
        isSuccess = false {
    if (errors.isEmpty) {
      throw ArgumentError('Errors cannot be empty in a failure result.');
    }
  }

  Result.singleError(String message)
      : value = null,
        errors = [RopError(message)],
        isSuccess = false;

  @override
  String toString() {
    return isSuccess ? 'Success: $value' : 'Failure: ${errors.join(", ")}';
  }
}
