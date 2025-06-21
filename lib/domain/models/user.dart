import 'package:criptohub/domain/utils/deep_equatable.dart';

final class User with DeepEquatable {
  final String id;
  final String name;
  final String email;
  final String phone;

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

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
  ];

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