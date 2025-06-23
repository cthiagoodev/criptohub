/// Exception thrown when an attribute is empty.
final class AttributeEmptyException implements Exception {
  final String errorMessage;

  const AttributeEmptyException([this.errorMessage = "Attribute cannot be empty"]);
}

/// Exception thrown when an attribute is unformatted.
final class AttributeUnformattedException implements Exception {
  final String errorMessage;

  const AttributeUnformattedException([this.errorMessage = "Attribute is unformatted"]);
}