import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String token;
  const UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
  });

  UserData copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? token,
  }) {
    return UserData(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'token': token,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(email: $email, firstName: $firstName, lastName: $lastName, token: $token)';
  }

  @override
  List<Object> get props => [email, firstName, lastName, token];
}
