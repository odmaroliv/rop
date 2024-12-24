import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Fallback Tests', () {
    test('Fallback on failure', () {
      final result = Result.singleError('An error occurred')
          .fallback(() => Result.success(42));
      expect(result.isSuccess, true);
      expect(result.value, 42);
    });

    test('No fallback on success', () {
      final result = Result.success(10).fallback(() => Result.success(42));
      expect(result.isSuccess, true);
      expect(result.value, 10);
    });
  });
}
