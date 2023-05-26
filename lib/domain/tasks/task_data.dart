import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskData extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deadline;
  final bool isCompleted;
  const TaskData({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deadline,
    required this.isCompleted,
  });

  TaskData copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deadline,
    bool? isCompleted,
  }) {
    return TaskData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'deadline': deadline.millisecondsSinceEpoch,
      'is_completed': isCompleted,
    };
  }

  factory TaskData.fromMap(Map<String, dynamic> map) {
    return TaskData(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: DateTime.parse(map['created_at']).toLocal(),
      updatedAt: DateTime.parse(map['updated_at']).toLocal(),
      deadline: DateTime.parse(map['deadline']).toLocal(),
      isCompleted: map['is_completed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskData.fromJson(String source) =>
      TaskData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskData(id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, deadline: $deadline, isCompleted: $isCompleted)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      createdAt,
      updatedAt,
      deadline,
      isCompleted,
    ];
  }
}
