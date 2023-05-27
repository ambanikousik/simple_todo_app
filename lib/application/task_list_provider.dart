import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/task_repo_provider.dart';
import 'package:simple_todo_app/domain/tasks/create_update_task_body.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';

// final taskListProvider = FutureProvider<IList<TaskData>>((ref) async {
//   final data = await ref.read(taskRepoProvider).getTasks();
//   return data.fold((l) => throw l.error, (r) => r);
// });

final taskListProvider =
    AsyncNotifierProvider<TaskListNotifier, IList<TaskData>>(
        TaskListNotifier.new);

class TaskListNotifier extends AsyncNotifier<IList<TaskData>> {
  @override
  Future<IList<TaskData>> build() async {
    final data = await loadTaskList();

    return data.fold((l) => const IListConst([]), (r) => r);
  }

  Future<Either<CleanFailure, IList<TaskData>>> loadTaskList() async {
    final data = await ref.read(taskRepoProvider).getTasks();
    return data.fold((l) => left(l),
        (r) => right(r.sort((a, b) => b.updatedAt.compareTo(a.updatedAt))));
  }

  Future<Option<CleanFailure>> updateTask(
      CreateUpdateTaskBody body, int taskId) async {
    final data = await ref.read(taskRepoProvider).updateTask(body, taskId);

    return await data.fold(() async {
      final dt = await loadTaskList();
      return dt.fold((l) => some(l), (r) {
        state = AsyncData(r);
        return none();
      });
    }, (t) => some(t));
  }

  Future<Option<CleanFailure>> createTask(
    CreateUpdateTaskBody body,
  ) async {
    final data = await ref.read(taskRepoProvider).createTask(
          body,
        );

    return await data.fold(() async {
      final dt = await loadTaskList();
      return dt.fold((l) => some(l), (r) {
        state = AsyncData(r);
        return none();
      });
    }, (t) => some(t));
  }
}
