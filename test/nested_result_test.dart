import 'package:rop/rop.dart';
import 'package:test/test.dart';

void main() {
  group('Nested Results', () {
    test('Unwrapping nested Result<Result<int>>', () {
      final nested = Result.success(Result.success(10));
      final unwrapped = nested.bind((inner) => inner);
      expect(unwrapped.isSuccess, true);
      expect(unwrapped.value, 10);
    });

    test('Nested Result with failure', () {
      final nested = Result.success(Result<int>.singleError('Inner error'));
      final unwrapped = nested.bind((inner) => inner);
      expect(unwrapped.isSuccess, false);
      expect(unwrapped.errors.first.message, 'Inner error');
    });
  });
}
