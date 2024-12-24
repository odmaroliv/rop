import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Result Tests', () {
    test('Success result', () {
      final result = Result<int>.success(10);
      expect(result.isSuccess, true);
      expect(result.value, 10);
    });

    test('Failure result', () {
      final result = Result<int>.singleError('An error occurred');
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'An error occurred');
    });

    test('Failure result with multiple errors', () {
      final errors = [RopError('Error 1'), RopError('Error 2')];
      final result = Result<int>.failure(errors);
      expect(result.isSuccess, false);
      expect(result.errors.length, 2);
    });
  });
}
