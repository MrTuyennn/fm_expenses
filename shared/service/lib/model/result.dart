import 'package:freezed_annotation/freezed_annotation.dart';

import 'exception.dart';

part 'result.freezed.dart';

/// # Result Class Documentation
///
/// The `Result` class is a utility class that represents the result of an operation, which can be either a success with
/// data of type `T` or a failure with an associated error of type `CoreException`. It is designed to handle errors
/// gracefully and provides convenient methods for working with success and failure scenarios.
///
/// ## Usage
///
/// To use the `Result` class, follow these steps:
///
/// ### 1. Create a `Result` Instance
///
/// #### Creating a Success Result:
///
/// ```dart
/// final result = Result.success(data: someData);
/// ```
///
/// Create a success result by providing the data of type `T`.
///
/// #### Creating a Failure Result:
///
/// ```dart
/// final result = Result.failure(error: someError);
/// ```
///
/// Create a failure result by providing a `CoreException` error.
///
/// ### 2. Guarding Code Blocks
///
/// Use the `guard` and `guardFuture` static methods to safely execute code blocks that may throw exceptions. These methods
/// wrap the code in a try-catch block and return a `Result`. If an exception is thrown, it is caught and converted into
/// a failure result with a `CoreException` error.
///
/// #### Guarding Synchronous Code:
///
/// ```dart
/// final result = Result.guard(() {
///   // Code that may throw exceptions
///   return someData;
/// });
/// ```
///
/// #### Guarding Asynchronous Code:
///
/// ```dart
/// final result = await Result.guardFuture(() async {
///   // Asynchronous code that may throw exceptions
///   return await fetchData();
/// });
/// ```
///
/// ### 3. Checking Result Status
///
/// You can check the status of the result using the following methods:
///
/// #### Checking for Success:
///
/// ```dart
/// final isSuccess = result.isSuccess;
/// ```
///
/// Returns `true` if the result represents a success, `false` otherwise.
///
/// #### Checking for Failure:
///
/// ```dart
/// final isFailure = result.isFailure;
/// ```
///
/// Returns `true` if the result represents a failure, `false` otherwise.
///
/// ### 4. Handling Success and Failure
///
/// Use the `ifSuccess` and `ifFailure` methods to execute code blocks based on the result status.
///
/// #### Handling Success:
///
/// ```dart
/// result.ifSuccess((data) {
///   // Code to execute if the result is a success
///   print(data);
/// });
/// ```
///
/// #### Handling Failure:
///
/// ```dart
/// result.ifFailure((error) {
///   // Code to execute if the result is a failure
///   print(error);
/// });
/// ```
///
/// ### 5. Accessing Data or Throwing Errors
///
/// Use the `dataOrThrow` property to access the data if the result is a success, or to throw the associated `CoreException`
/// error if the result is a failure.
///
/// ```dart
/// try {
///   final data = result.dataOrThrow;
///   // Use the data
/// } catch (e) {
///   // Handle the error
/// }
/// ```
///
/// ## Example
///
/// Here's an example of how to use the `Result` class in a Dart application:
///
/// ```dart
/// void main() {
///   final result = Result.guard(() {
///     // Simulate a successful operation
///     return 'Success data';
///   });
///
///   if (result.isSuccess) {
///     print('Operation succeeded');
///     result.ifSuccess((data) {
///       print('Data: $data');
///     });
///   } else {
///     print('Operation failed');
///     result.ifFailure((error) {
///       print('Error: $error');
///     });
///   }
/// }
/// ```
///
/// In this example, the `Result` class is used to handle the result of a code block that may throw exceptions.
/// Depending on whether the operation succeeds or fails, the appropriate code block is executed.

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success({required T data}) = Success<T>;

  const factory Result.failure({required CoreException error}) = Failure<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(data: body());
    } on Exception catch (e) {
      return Result.failure(error: CoreException(e));
    }
  }

  static Future<Result<T>> guardFuture<T>(Future<T> Function() future) async {
    try {
      return Result.success(data: await future());
    } on Exception catch (e) {
      return Result.failure(error: CoreException(e));
    } catch (e) {
      return Result.failure(error: CoreException(Exception(e.toString())));
    }
  }

  bool get isSuccess => when(success: (data) => true, failure: (e) => false);

  bool get isFailure => !isSuccess;

  void ifSuccess(Function(T data) body) {
    maybeWhen(
      success: (data) => body(data),
      orElse: () {
        // no-op
      },
    );
  }

  void ifFailure(Function(CoreException e) body) {
    maybeWhen(
      failure: (e) => body(e),
      orElse: () {
        // no-op
      },
    );
  }

  T get dataOrThrow {
    return when(success: (data) => data, failure: (e) => throw e);
  }
}

extension ResultObjectX<T> on T {
  Result<T> get asSuccess => Result.success(data: this);

  Result<T> asFailure(Exception e) => Result.failure(error: CoreException(e));
}
