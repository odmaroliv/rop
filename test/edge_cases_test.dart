import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Edge Cases', () {
    test('Result.success with null value (not allowed)', () {
      expect(() => Result.success(null), throwsArgumentError);
    });

    test('Result.failure with empty error list (not allowed)', () {
      expect(() => Result.failure([]), throwsArgumentError);
    });

    test('Traverse with empty list', () {
      final List<Result<int>> results = [];
      final traversed = results.traverse();
      expect(traversed.isSuccess, true);
      expect(traversed.value, []);
    });

    test('Traverse with all failures', () {
      final results = [
        Result<int>.singleError('Error 1'),
        Result<int>.singleError('Error 2'),
      ];
      final traversed = results.traverse();
      expect(traversed.isSuccess, false);
      expect(traversed.errors.length, 2);
    });
  });
}
