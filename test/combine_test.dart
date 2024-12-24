import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Combine Tests', () {
    test('Combine two success results', () {
      final result1 = Result.success(10);
      final result2 = Result.success(20);
      final combined = result1.combine(result2);

      expect(combined.isSuccess, true);
      expect(combined.value?.item1, 10);
      expect(combined.value?.item2, 20);
    });

    test('Combine with a failure result', () {
      final result1 = Result.success(10);
      final result2 = Result<int>.singleError('An error occurred');
      final combined = result1.combine(result2);

      expect(combined.isSuccess, false);
      expect(combined.errors.first.message, 'An error occurred');
    });
  });
}
