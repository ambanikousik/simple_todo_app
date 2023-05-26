import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegistrationBody extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  const RegistrationBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  RegistrationBody copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    return RegistrationBody(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }

  factory RegistrationBody.fromMap(Map<String, dynamic> map) {
    return RegistrationBody(
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationBody.fromJson(String source) =>
      RegistrationBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrationBody(firstName: $firstName, lastName: $lastName, email: $email, password: $password)';
  }

  @override
  List<Object> get props => [firstName, lastName, email, password];
}
