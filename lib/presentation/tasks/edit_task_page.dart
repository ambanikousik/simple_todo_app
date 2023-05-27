import 'package:flutter/material.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';

class EditTaskPage extends StatelessWidget {
  final TaskData task;
  const EditTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit task'),
      ),
    );
  }
}
