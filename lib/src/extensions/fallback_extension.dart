import '../result.dart';

extension FallbackExtension<T> on Result<T> {
  Result<T> fallback(Result<T> Function() alternative) {
    return isSuccess ? this : alternative();
  }

  Future<Result<T>> fallbackAsync(
      Future<Result<T>> Function() alternative) async {
    return isSuccess ? this : await alternative();
  }
}
