import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateUpdateTaskBody extends Equatable {
  final String title;
  final String description;
  final DateTime deadline;
  final bool isCompleted;
  const CreateUpdateTaskBody({
    required this.title,
    required this.description,
    required this.deadline,
    required this.isCompleted,
  });

  CreateUpdateTaskBody copyWith({
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
  }) {
    return CreateUpdateTaskBody(
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.toUtc().toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  factory CreateUpdateTaskBody.fromMap(Map<String, dynamic> map) {
    return CreateUpdateTaskBody(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      deadline: DateTime.parse(map['deadline']),
      isCompleted: map['is_completed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUpdateTaskBody.fromJson(String source) =>
      CreateUpdateTaskBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskData(title: $title, description: $description, deadline: $deadline, isCompleted: $isCompleted)';
  }

  @override
  List<Object> get props => [title, description, deadline, isCompleted];
}
