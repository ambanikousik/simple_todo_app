import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/task_repo_provider.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';

final taskListProvider = FutureProvider<IList<TaskData>>((ref) async {
  final data = await ref.read(taskRepoProvider).getTasks();
  return data.fold((l) => throw l.error, (r) => r);
});
