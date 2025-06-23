/// Represents the result of an operation.
/// It can either be successful or fail.
/// If it is successful, [data] will contain the result of the operation.
/// If it fails, [error] will contain the exception that caused the failure.
/// If it fails, [errorMessage] will contain a message describing the failure.
/// If it is empty, [data], [error], and [errorMessage] will be null.
final class Result<T> {
  final T? data;
  final Exception? error;
  final String? errorMessage;

  const Result({
    required this.data,
    required this.error,
    required this.errorMessage,
  });

  bool get isSuccess => error == null && data != null;
  bool get isError => error != null;
  bool get isEmpty => data == null && error == null && errorMessage == null;

  factory Result.success(T data) {
    return Result<T>(
      data: data,
      error: null,
      errorMessage: null,
    );
  }

  factory Result.error({
    required Exception error,
    required String errorMessage,
  }) {
    return Result<T>(
      data: null,
      error: error,
      errorMessage: errorMessage,
    );
  }

  factory Result.empty() {
    return Result<T>(
      data: null,
      error: null,
      errorMessage: null,
    );
  }
}