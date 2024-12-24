import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Then Tests', () {
    test('Then executes on success', () {
      var executed = false;
      final result = Result.success(10).then((value) {
        executed = true;
      });
      expect(result.isSuccess, true);
      expect(executed, true);
    });

    test('Then does not execute on failure', () {
      var executed = false;
      final result = Result<int>.singleError('An error occurred').then((value) {
        executed = true;
      });
      expect(result.isSuccess, false);
      expect(executed, false);
    });

    test('ThenAsync executes on success', () async {
      var executed = false;
      final result = await Result.success(10).thenAsync((value) async {
        executed = true;
      });
      expect(result.isSuccess, true);
      expect(executed, true);
    });

    test('ThenAsync does not execute on failure', () async {
      var executed = false;
      final result = await Result<int>.singleError('An error occurred')
          .thenAsync((value) async {
        executed = true;
      });
      expect(result.isSuccess, false);
      expect(executed, false);
    });
  });
}
