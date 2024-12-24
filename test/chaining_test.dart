import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Method Chaining', () {
    Result<int> doubleIfPositive(int value) {
      return value > 0
          ? Result.success(value * 2)
          : Result.singleError('Not positive');
    }

    Result<String> toStringResult(int value) {
      return Result.success('Value: $value');
    }

    test('Chaining success results', () {
      final result =
          Result.success(5).bind(doubleIfPositive).bind(toStringResult);
      expect(result.isSuccess, true);
      expect(result.value, 'Value: 10');
    });

    test('Chaining with a failure in the middle', () {
      final result =
          Result.success(-1).bind(doubleIfPositive).bind(toStringResult);
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'Not positive');
    });
  });
}
