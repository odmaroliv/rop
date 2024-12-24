import 'package:rop/rop.dart';

extension TraverseExtension<T extends Object> on List<Result<T>> {
  Result<List<T>> traverse() {
    final successes = <T>[];
    final errors = <RopError>[];

    for (var result in this) {
      if (result.isSuccess) {
        successes.add(result.value!); // Seguro porque T no puede ser nulo.
      } else {
        errors.addAll(result.errors);
      }
    }

    if (errors.isEmpty) {
      return Result.success(successes);
    }
    return Result.failure(errors);
  }
}
