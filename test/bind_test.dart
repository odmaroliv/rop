import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Bind Tests', () {
    Result<int> doubleIfPositive(int value) {
      if (value > 0) {
        return Result<int>.success(value * 2);
      }
      return Result<int>.singleError('Value is not positive');
    }

    test('Bind with success result', () {
      final result = Result<int>.success(10).bind(doubleIfPositive);
      expect(result.isSuccess, true);
      expect(result.value, 20);
    });

    test('Bind with failure result', () {
      final result = Result<int>.success(-1).bind(doubleIfPositive);
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'Value is not positive');
    });

    test('Bind does not execute on failure', () {
      final result =
          Result<int>.singleError('Initial error').bind(doubleIfPositive);
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'Initial error');
    });
  });
}
