import 'package:rop/rop.dart';

void main() async {
  print('--- Caso Perfecto ---');
  final perfectFlow = await validateUserInput('new_user', 'password123')
      .bind(validatePasswordStrength)
      .bindAsync(checkIfUserExists)
      .bindAsync(saveUser);
  handleResult(perfectFlow);

  print('\n--- Caso con Errores ---');
  final errorFlow = await validateUserInput('', 'weak')
      .bind(validatePasswordStrength)
      .bindAsync(checkIfUserExists)
      .bindAsync(saveUser);
  handleResult(errorFlow);

  print('\n--- Caso Complejo ---');
  final complexFlow = await validateUserInput('user123', '')
      .bind(validatePasswordStrength)
      .bindAsync(checkIfUserExists)
      .bindAsync(saveUser)
      .fallbackAsync(() =>
          handleErrorAndSuggestAlternative()); // Fallback para manejar fallos
  handleResult(complexFlow);

  print('\n--- Validaciones Múltiples ---');
  final multipleValidations = await validateMultipleInputs([
    {'username': 'user123', 'password': ''},
    {'username': '', 'password': 'password123'},
    {'username': 'valid_user', 'password': 'valid_password'}
  ]);
  handleResult(multipleValidations);
}

/// Valida la entrada inicial del usuario
Result<Map<String, String>> validateUserInput(
    String username, String password) {
  final errors = <RopError>[];

  if (username.isEmpty) {
    errors.add(RopError('El nombre de usuario no puede estar vacío.'));
  }
  if (password.isEmpty) {
    errors.add(RopError('La contraseña no puede estar vacía.'));
  }

  return errors.isEmpty
      ? Result.success({'username': username, 'password': password})
      : Result.failure(errors);
}

/// Valida la fortaleza de la contraseña
Result<Map<String, String>> validatePasswordStrength(
    Map<String, String> input) {
  final password = input['password']!;
  if (password.length < 6) {
    return Result.singleError('La contraseña es demasiado débil.');
  }
  return Result.success(input);
}

/// Simula una comprobación asincrónica para verificar si el usuario ya existe
Future<Result<Map<String, String>>> checkIfUserExists(
    Map<String, String> input) async {
  await Future.delayed(
      Duration(milliseconds: 500)); // Simula una consulta a una base de datos
  final username = input['username']!;
  if (username == 'user123') {
    return Result.singleError('El nombre de usuario ya está en uso.');
  }
  return Result.success(input);
}

/// Simula guardar al usuario en la base de datos
Future<Result<String>> saveUser(Map<String, String> input) async {
  await Future.delayed(Duration(
      milliseconds:
          500)); // Simula una operación de escritura en una base de datos
  return Result.success('Usuario ${input['username']} guardado exitosamente.');
}

/// Fallback: Maneja errores y sugiere alternativas
Future<Result<String>> handleErrorAndSuggestAlternative() async {
  print('⚠️ Se encontraron errores:');
  print('Creando usuario temporal...');
  await Future.delayed(Duration(milliseconds: 500));
  return Result.success('Usuario temporal creado exitosamente.');
}

/// Valida múltiples entradas simultáneamente usando `traverse`
Future<Result<List<String>>> validateMultipleInputs(
    List<Map<String, String>> inputs) async {
  final results = inputs.map((input) {
    return validateUserInput(input['username']!, input['password']!)
        .bind(validatePasswordStrength)
        .map((validated) =>
            'Usuario: ${validated['username']} con contraseña validada');
  }).toList();

  return results.traverse();
}

/// Maneja el resultado final
void handleResult<T>(Result<T> result) {
  if (result.isSuccess) {
    print('✅ Operación exitosa: ${result.value}');
  } else {
    print('❌ Error(es):');
    for (final error in result.errors) {
      print('- ${error.message}');
    }
  }
}
