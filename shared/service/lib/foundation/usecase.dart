import 'param.dart';

interface class BaseUseCase<T> {}

/// An abstract base class for use cases that require parameters.
///
/// This class serves as a template for use cases that take an input of type [P],
/// which extends from [IParam], and return a result of type [T].
/// Subclasses should implement the [call] method to define the specific use case logic.
///
/// Example:
/// ```dart
/// class FetchUserUseCase extends UseCase<User, UserParams> {
///   @override
///   Future<User> call(UserParams param) {
///     // Implementation here
///   }
/// }
/// ```
abstract base class UseCase<T, P extends IParam> implements BaseUseCase<T> {
  const UseCase();

  Future<T> call(P param);
}

/// An abstract base class for use cases that do not require any parameters.
///
/// This class serves as a template for use cases that return a result of type [T]
/// without needing any input parameters. Subclasses should implement the [call]
/// method to define the specific use case logic.
///
/// Example:
/// ```dart
/// class GetDataUseCase extends NoParamsUseCase<Data> {
///   @override
///   Future<Data> call() {
///     // Implementation here
///   }
/// }
/// ```
abstract base class NoParamsUseCase<T> implements BaseUseCase<T> {
  const NoParamsUseCase();

  Future<T> call();
}
