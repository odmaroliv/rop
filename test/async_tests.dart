import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Asynchronous Methods', () {
    Future<Result<int>> asyncDouble(int value) async {
      await Future.delayed(Duration(milliseconds: 10));
      return Result.success(value * 2);
    }

    Future<Result<String>> asyncStringify(int value) async {
      await Future.delayed(Duration(milliseconds: 10));
      return Result.success('Value: $value');
    }

    test('Async chaining success', () async {
      final result = await Result.success(5)
          .bindAsync(asyncDouble)
          .bindAsync(asyncStringify);
      expect(result.isSuccess, true);
      expect(result.value, 'Value: 10');
    });

    test('Async chaining with failure', () async {
      final result = await Result.success(-1)
          .bindAsync(asyncDouble)
          .bindAsync(asyncStringify);
      expect(result.isSuccess, false);
    });
  });
}
