import '../mixin/cancelable_operations_mixin.dart';
import '../model/exception.dart';
import '../model/response.dart';
import 'rest_client.io.dart';

/// A mixin that provides a scoped execution environment for API requests.
///
/// This mixin integrates with [CancelableOperationsMixin] to handle the lifecycle
/// of an API call, including automatic cancellation and resource disposal via the [client].
/// It also standardizes the unwrapping of [BaseResponse] data.
mixin ApiScopeMixin on CancelableOperationsMixin {
  /// Executes an API operation within a cancelable scope.
  ///
  /// This method wraps the [operation] to ensure it can be canceled safely.
  /// If the operation completes successfully, it unwraps and returns the data of type [T].
  ///
  /// - [client]: The [IRestClient] instance used for the request. Used for identifying
  ///   the scope and handling disposal via [client.onDispose] if canceled.
  /// - [operation]: A function returning a [Future] of [BaseResponse]. This is the actual API call.
  /// - [key]: An optional unique identifier for this operation. If not provided,
  ///   it defaults to the [client]'s hash code (implying one active request per client instance).
  ///
  /// Returns the data [T] from the [BaseResponse].
  ///
  /// Throws a [CoreException.nullReferenceException] if the result or data is null
  /// despite a successful execution flow.
  Future<T> runApiScope<T>(
    IRestClient client,
    Future<BaseResponse<T>> Function(IRestClient client) operation, [
    String? key,
  ]) async {
    final result = await runCancelable(
      key ?? '${client.hashCode}',
      operation(client),
      onCanceled: client.onDispose,
    );

    try {
      return result!.data!;
    } catch (_) {
      throw CoreException.nullReferenceException(result?.message, result?.code);
    }
  }
}
