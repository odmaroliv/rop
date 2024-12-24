# ROP: Railway Oriented Programming for Dart 🚂

[![Pub Version](https://img.shields.io/pub/v/rop.svg)](https://pub.dev/packages/rop)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

ROP is a powerful library designed to handle errors in a structured and fluent way using the `Result<T>` structure. Inspired by functional programming principles, it enables clear workflows that separate success and error paths.

## 📦 Installation

Add the library to your project:

```bash
dart pub add rop
```

Import the library into your code:

```dart
import 'package:rop/rop.dart';
```

## 🚀 Core Structure

### Result<T>

`Result<T>` is a generic class that represents the outcome of an operation. It can be:

- **Success**: Contains a value of type `T`
- **Failure**: Contains a list of errors (`List<RopError>`)

### Static Methods

- `Result.success(T value)` – Creates a successful result
- `Result.failure(List<RopError> errors)` – Creates a failed result with multiple errors
- `Result.singleError(String message)` – Creates a failed result with a single error

Example:

```dart
final success = Result.success(42);
final failure = Result.singleError('Processing error');
```

## 🛠 Available Extensions

### 1. bind

Chains dependent methods. If the result is successful, it executes the next step.

```dart
Result<U> bind<U>(Result<U> Function(T) fn)

// Example:
Result<int> doubleIfPositive(int value) =>
    value > 0 ? Result.success(value * 2) : Result.singleError('Not positive');

final result = Result.success(5).bind(doubleIfPositive);
print(result.value); // 10
```

### 2. bindAsync

Asynchronous version of bind.

```dart
Future<Result<U>> bindAsync<U>(Future<Result<U>> Function(T) fn)

// Example:
Future<Result<int>> asyncDouble(int value) async =>
    Result.success(value * 2);

final result = await Result.success(5).bindAsync(asyncDouble);
```

### 3. map

Transforms the value of a successful result.

```dart
Result<U> map<U>(U Function(T) mapper)

// Example:
final result = Result.success(5).map((x) => 'Value: $x');
```

### 4. mapAsync

Asynchronous version of map.

```dart
Future<Result<U>> mapAsync<U>(Future<U> Function(T) mapper)

// Example:
Future<String> asyncStringify(int value) async => 'Value: $value';
final result = await Result.success(5).mapAsync(asyncStringify);
```

### 5. combine

Combines two results into a tuple if both are successful.

```dart
Result<Tuple2<T, U>> combine<U>(Result<U> other)

// Example:
final result1 = Result.success(10);
final result2 = Result.success(20);
final combined = result1.combine(result2);
```

### 6. traverse

Converts a list of `Result<T>` into a `Result<List<T>>`.

```dart
Result<List<T>> traverse()

// Example:
final results = [
  Result.success(1),
  Result.success(2),
  Result.success(3)
];
final traversed = results.traverse();
```

### 7. then

Executes an action if the result is successful.

```dart
Result<T> then(void Function(T) action)

// Example:
Result.success(5).then((value) => print('Value: $value'));
```

### 8. fallback & fallbackAsync

Provides alternative results in case of failure.

```dart
Result<T> fallback(Result<T> Function() alternative)
Future<Result<T>> fallbackAsync(Future<Result<T>> Function() alternative)

// Example:
final result = Result.singleError('Error').fallback(() => Result.success(42));
```

## 🎯 Complete Example

```dart
Future<void> main() async {
  final result = await validateInput('user123', 'password123')
      .bind(validatePasswordStrength)
      .bindAsync(checkUserExists)
      .bindAsync(saveUser)
      .fallbackAsync(() => createTemporaryUser());

  handleResult(result);
}

Result<Map<String, String>> validateInput(String username, String password) {
  if (username.isEmpty) return Result.singleError('Username cannot be empty.');
  if (password.isEmpty) return Result.singleError('Password cannot be empty.');
  return Result.success({'username': username, 'password': password});
}

Result<Map<String, String>> validatePasswordStrength(Map<String, String> input) {
  if (input['password']!.length < 6) return Result.singleError('Weak password.');
  return Result.success(input);
}

Future<Result<String>> checkUserExists(Map<String, String> input) async {
  if (input['username'] == 'user123') return Result.singleError('Username already exists.');
  return Result.success(input['username']!);
}

Future<Result<String>> saveUser(String username) async {
  return Result.success('User $username saved.');
}

Future<Result<String>> createTemporaryUser() async {
  return Result.success('Temporary user created.');
}

void handleResult<T>(Result<T> result) {
  if (result.isSuccess) {
    print('✅ Success: ${result.value}');
  } else {
    print('❌ Error(s):');
    for (final error in result.errors) {
      print('- ${error.message}');
    }
  }
}
```

## 🤝 Contributing

We welcome contributions to ROP! Here's how you can help:

1. **Fork the Repository**

   - Fork the project on GitHub
   - Clone your fork locally

2. **Create a Branch**

   - Create a new branch for your feature or bugfix
   - Use a descriptive name (e.g., `feature/new-extension` or `fix/error-handling`)

3. **Make Your Changes**

   - Write your code
   - Add or update tests as needed
   - Update documentation if necessary

4. **Test Your Changes**

   - Run the existing test suite: `dart test`
   - Ensure all tests pass
   - Add new tests for new functionality

5. **Submit a Pull Request**
   - Push your changes to your fork
   - Submit a pull request from your branch to our main branch
   - Provide a clear description of your changes
   - Reference any related issues

## 📄 License

This project is licensed under the MIT License - see below for details:

[LICENSE](./LICENSE)

## ✨ Features & Bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/odmaroliv/rop/issues).
