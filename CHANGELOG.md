# Changelog

All notable changes to the ROP library will be documented in this file.

## [1.0.0] - 2024-12-23

### Added

- Initial release of the ROP (Railway Oriented Programming) library 🎉

#### Core Features

- `Result<T>` structure for representing operation outcomes
  - `Result.success` for successful operations
  - `Result.failure` for failed operations
  - Built-in properties: `isSuccess`, `value`, and `errors`

#### Extensions

- Synchronous operations

  - `bind` for chaining dependent operations
  - `map` for value transformation
  - `then` for side effects on success
  - `fallback` for providing alternative results
  - `combine` for joining two successful results into a tuple
  - `traverse` for converting `List<Result<T>>` to `Result<List<T>>`

- Asynchronous operations
  - `bindAsync` for asynchronous operation chaining
  - `mapAsync` for asynchronous value transformation
  - `fallbackAsync` for asynchronous fallback handling

#### Error Handling

- `RopError` class with message property
- Support for multiple error aggregation in `Result.failure`
- Comprehensive error propagation in both sync and async workflows

[1.0.0]: https://github.com/odmaroliv/rop/releases/tag/v1.0.0
