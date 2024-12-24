import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Map Tests', () {
    test('Map with success result', () {
      final result = Result.success(10).map((x) => x * 2);
      expect(result.isSuccess, true);
      expect(result.value, 20);
    });

    test('Map does not execute on failure', () {
      final result =
          Result<int>.singleError('An error occurred').map((x) => x.toString());
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'An error occurred');
    });

    test('MapAsync with success result', () async {
      Future<String> asyncStringify(int value) async {
        return 'Value: $value';
      }

      final result = await Result.success(10).mapAsync(asyncStringify);
      expect(result.isSuccess, true);
      expect(result.value, 'Value: 10');
    });

    test('MapAsync does not execute on failure', () async {
      Future<String> asyncStringify(int value) async {
        return 'Value: $value';
      }

      final result = await Result<int>.singleError('An error occurred')
          .mapAsync(asyncStringify);
      expect(result.isSuccess, false);
      expect(result.errors.first.message, 'An error occurred');
    });
  });
}
