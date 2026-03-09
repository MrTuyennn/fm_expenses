import 'dart:async';

import 'package:async/async.dart';

/// Mixin for managing multiple cancelable async operations
///
/// Usage:
/// ```dart
/// class MyNotifier extends Notifier<MyState> with CancelableOperationsMixin {
///   @override
///   MyState build() {
///     ref.onDispose(() {
///       cancelAllOperations();
///     });
///     return MyState();
///   }
///
///   Future<void> fetchData(String id) async {
///     final result = await runCancelable(
///       id, // or just use an identifier, will be prefixed with class hashCode
///       () => api.fetchData(id),
///     );
///     // Handle result
///   }
/// }
/// ```
mixin CancelableOperationsMixin {
  final Map<String, CancelableOperation> _operations = {};

  /// Run a cancelable operation with a unique key
  ///
  /// The key will be automatically prefixed with the class instance's hashCode.
  /// If an operation with the same key exists, it will be canceled first.
  /// Returns the result of the operation or null if canceled/failed.
  ///
  /// [onError] callback is called when an error occurs (not for cancellation).
  Future<T?> runCancelable<T>(
    String key,
    Future<T> operation, {
    bool cancelExisting = true,
    void Function(T? result)? onCompleted,
    void Function()? onCanceled,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    // Cancel existing operation with the same key if requested
    if (cancelExisting) {
      await cancelOperation(key);
    }

    // Create and store the cancelable operation
    final cancelable = CancelableOperation.fromFuture(
      operation,
      onCancel: () {
        _operations.remove(key);
      },
    );

    _operations[key] = cancelable;

    try {
      // Use valueOrCancellation to handle cancellation gracefully
      final result = await cancelable.valueOrCancellation();
      _operations.remove(key);
      if (cancelable.isCompleted) {
        onCompleted?.call(result);
      } else {
        onCanceled?.call();
      }
      return result;
    } catch (e, stackTrace) {
      _operations.remove(key);
      onError?.call(e, stackTrace);
      return null;
    }
  }

  /// Run a cancelable operation and provide a callback with the CancelableOperation
  ///
  /// Useful when you need access to the operation itself (e.g., for valueOrCancellation)
  /// [onError] callback is called when an error occurs (not for cancellation).
  Future<T?> runCancelableWithOp<T>(
    String key,
    Future<T> Function(CancelableOperation<T> operation) callback, {
    bool cancelExisting = true,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    if (cancelExisting) {
      await cancelOperation(key);
    }

    late CancelableOperation<T> cancelable;
    final completer = Completer<T>();

    cancelable = CancelableOperation.fromFuture(
      completer.future,
      onCancel: () {
        _operations.remove(key);
      },
    );

    _operations[key] = cancelable;

    try {
      final result = await callback(cancelable);
      completer.complete(result);
      final value = await cancelable.valueOrCancellation();
      _operations.remove(key);
      return value;
    } catch (e, stackTrace) {
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
      _operations.remove(key);
      onError?.call(e, stackTrace);
      return null;
    }
  }

  /// Cancel a specific operation by key suffix
  ///
  /// Returns true if an operation was found and canceled, false otherwise.
  Future<bool> cancelOperation(String key) async {
    final operation = _operations.remove(key);
    if (operation != null) {
      await operation.cancel();
      return true;
    }
    return false;
  }

  /// Cancel multiple operations by their key suffixes
  Future<void> cancelOperations(Iterable<String> keys) {
    return Future.wait([for (final k in keys) cancelOperation(k)]);
  }

  /// Cancel all active operations
  Future<void> cancelAllOperations() {
    final operations = Map<String, CancelableOperation>.from(_operations);
    _operations.clear();

    return Future.wait([for (final op in operations.values) op.cancel()]);
  }
}
