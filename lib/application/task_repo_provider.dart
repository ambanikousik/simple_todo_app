import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/domain/tasks/i_task_repo.dart';
import 'package:simple_todo_app/infrastructure/task_repo.dart';

final taskRepoProvider = Provider<ITaskRepo>((ref) {
  return TaskRepo();
});
