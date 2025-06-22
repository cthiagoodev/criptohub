import 'package:criptohub/domain/exceptions/http_exceptions.dart';
import 'package:criptohub/domain/models/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ResultModel Test", () {
    test("Must return a success result", () {
      final ApiResponse response = ApiResponse.generate();
      final Result<ApiResponse> result = Result.success(response);

      expect(result.data, isNotNull);
      expect(result.error, isNull);
      expect(result.errorMessage, isNull);
      expect(result.isSuccess, isTrue);
      expect(result.isError, isFalse);
      expect(result.isEmpty, isFalse);
    });

    test("Must return a error result", () {
      final Result<ApiResponse> result = Result.error(
        error: HttpInternalServerErrorException("Error on test case"),
        errorMessage: "Error on test case",
      );

      expect(result.data, isNull);
      expect(result.error, isNotNull);
      expect(result.error, isA<Exception>());
      expect(result.errorMessage, isNotNull);
      expect(result.isSuccess, isFalse);
      expect(result.isError, isTrue);
      expect(result.isEmpty, isFalse);
    });

    test("Must return a empty result", () {
      final Result<ApiResponse> result = Result.empty();

      expect(result.data, isNull);
      expect(result.error, isNull);
      expect(result.errorMessage, isNull);
      expect(result.isSuccess, isFalse);
      expect(result.isError, isFalse);
      expect(result.isEmpty, isTrue);
    });
  });
}

final class ApiResponse {
  final int id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ApiResponse({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApiResponse.generate() {
    return ApiResponse(
      id: 1,
      description: "This is a description on test case",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}