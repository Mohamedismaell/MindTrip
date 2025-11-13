import '../errors/failure.dart';

/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
///
/// Use [when] to pattern-match on the result and handle both cases.
/// For example:
/// ```dart
/// result.when(
///   success: (value) => print('Success: $value'),
///   failure: (error) => print('Error: $error'),
/// );
/// ```
/// This approach encourages explicit error handling and avoids exceptions.
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Failure error) = Error._;

  /// Pattern-matching for [Result].
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure error) failure,
  }) {
    switch (this) {
      case Ok(:final value):
        return success(value);
      case Error(:final error):
        return failure(error);
    }
  }
}

/// A successful [Result] with a returned [value].
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// The returned value of this result.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// An error [Result] with a resulting [error].
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// The resulting error of this result.
  final Failure error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
