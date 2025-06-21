import 'package:criptohub/domain/utils/deep_equatable.dart';

/// Represents a user in the application.
final class User with DeepEquatable {
  /// The unique identifier of the user.
  final String id;
  /// The name of the user.
  final String name;
  /// The email address of the user.
  final String email;
  /// The phone number of the user.
  final String phone;

  /// Creates a new [User] instance.
  ///
  /// Throws an [ArgumentError] if [id], [name], [email], or [phone] are empty.
  /// Throws a [FormatException] if the [email] is not a valid email format.
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  }) {
    if(id.isEmpty) {
      throw ArgumentError('Id cannot be empty');
    }

    if(name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }

    if(email.isEmpty) {
      throw ArgumentError('Email cannot be empty');
    }

    if(!email.contains('@')) {
      throw FormatException('Invalid email');
    }

    if(phone.isEmpty) {
      throw ArgumentError('Phone cannot be empty');
    }
  }

  /// The list of properties used for equality comparison.
  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
  ];

  /// Creates a copy of this [User] but with the given fields replaced with the new values.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}