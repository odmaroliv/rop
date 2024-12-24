import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Error Handling', () {
    test('Single error propagation', () {
      final result = Result<int>.singleError('Error occurred');
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'Error occurred');
    });

    test('Multiple errors propagation', () {
      final errors = [RopError('Error 1'), RopError('Error 2')];
      final result = Result<int>.failure(errors);
      expect(result.isSuccess, false);
      expect(result.errors.length, 2);
    });

    test('Combining success and failure results', () {
      final result1 = Result<int>.success(10);
      final result2 = Result<int>.singleError('Error occurred');
      final combined = result1.combine(result2);
      expect(combined.isSuccess, false);
      expect(combined.errors.first.message, 'Error occurred');
    });
  });
}
