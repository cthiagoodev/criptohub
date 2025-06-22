/// Exception for when the server cannot or will not process the request due to an apparent client error.
final class HttpBadRequestException implements Exception {
  final String errorMessage;
  final int statusCode = 400;

  const HttpBadRequestException([this.errorMessage = "Bad Request"]);
}

/// Exception for when authentication is required and has failed or has not yet been provided.
final class HttpUnauthorizedException implements Exception {
  final String errorMessage;
  final int statusCode = 401;

  const HttpUnauthorizedException([this.errorMessage = "Unauthorized"]);
}

/// Exception for when the server understood the request but refuses to authorize it.
final class HttpForbiddenException implements Exception {
  final String errorMessage;
  final int statusCode = 403;

  const HttpForbiddenException([this.errorMessage = "Forbidden"]);
}

/// Exception for when the target resource has been permanently moved.
final class HttpMovedPermanentlyException implements Exception {
  final String errorMessage;
  final int statusCode = 301;

  const HttpMovedPermanentlyException([this.errorMessage = "Moved Permanently"]);
}

/// Exception for when the target resource has been temporarily moved.
final class HttpFoundException implements Exception {
  final String errorMessage;
  final int statusCode = 302;

  const HttpFoundException([this.errorMessage = "Found"]);
}

/// Exception for when the request could not be completed due to a conflict with the current state of the target resource.
final class HttpConflictException implements Exception {
  final String errorMessage;
  final int statusCode = 409;

  const HttpConflictException([this.errorMessage = "Conflict"]);
}

/// Exception for when the server encountered an unexpected condition that prevented it from fulfilling the request.
final class HttpInternalServerErrorException implements Exception {
  final String errorMessage;
  final int statusCode = 500;

  const HttpInternalServerErrorException([this.errorMessage = "Internal Server Error"]);
}

/// Exception for when the server does not support the functionality required to fulfill the request.
final class HttpNotImplementedException implements Exception {
  final String errorMessage;
  final int statusCode = 501;

  const HttpNotImplementedException([this.errorMessage = "Not Implemented"]);
}

/// Exception for when the server, while acting as a gateway or proxy, received an invalid response from an inbound server it accessed while attempting to fulfill the request.
final class HttpBadGatewayException implements Exception {
  final String errorMessage;
  final int statusCode = 502;

  const HttpBadGatewayException([this.errorMessage = "Bad Gateway"]);
}

/// Exception for when the server is not ready to handle the request.
final class HttpServiceUnavailableException implements Exception {
  final String errorMessage;
  final int statusCode = 503;

  const HttpServiceUnavailableException([this.errorMessage = "Service Unavailable"]);
}

/// Exception for when the server, while acting as a gateway or proxy, did not receive a timely response from an upstream server.
final class HttpGatewayTimeoutException implements Exception {
  final String errorMessage;
  final int statusCode = 504;

  const HttpGatewayTimeoutException([this.errorMessage = "Gateway Timeout"]);
}