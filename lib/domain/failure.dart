import 'dart:convert';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String code;
  final String detail;
  const Failure({
    required this.code,
    required this.detail,
  });

  Failure copyWith({
    String? code,
    String? detail,
  }) {
    return Failure(
      code: code ?? this.code,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'detail': detail,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      code: map['code'] ?? '',
      detail: map['detail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source));

  @override
  String toString() => 'Failure(code: $code, detail: $detail)';

  @override
  List<Object> get props => [code, detail];
}
