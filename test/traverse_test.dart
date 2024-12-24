import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Traverse Tests', () {
    test('Traverse all success results', () {
      final List<Result<int>> results = [
        Result<int>.success(10),
        Result<int>.success(20),
        Result<int>.success(30),
      ];
      final traversed = results.traverse();

      expect(traversed.isSuccess, true);
      expect(traversed.value, [10, 20, 30]);
    });

    test('Traverse with a failure result', () {
      final List<Result<int>> results = [
        Result<int>.success(10),
        Result<int>.singleError('An error occurred'),
        Result<int>.success(30),
      ];
      final traversed = results.traverse();

      expect(traversed.isSuccess, false);
      expect(traversed.errors.first.message, 'An error occurred');
    });
  });
}
