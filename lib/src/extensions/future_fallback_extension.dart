import '../result.dart';

extension FutureFallbackExtension<T> on Future<Result<T>> {
  Future<Result<T>> fallbackAsync(
      Future<Result<T>> Function() alternative) async {
    final result = await this; // Espera el resultado actual
    return result.isSuccess ? result : await alternative();
  }
}
