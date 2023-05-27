import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:simple_todo_app/domain/tasks/create_update_task_body.dart';
import 'package:simple_todo_app/domain/tasks/i_task_repo.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';

class TaskRepo extends ITaskRepo {
  final api = CleanApi.instance;
  @override
  Future<Option<CleanFailure>> createTask(CreateUpdateTaskBody body) async {
    final data = await api.post(
        fromData: (data) => data, body: body.toMap(), endPoint: '/tasks/');

    return data.fold((l) => some(l), (r) => none());
  }

  @override
  Future<Option<CleanFailure>> deleteTasks(int taskId) {
    // TODO: implement deleteTasks
    throw UnimplementedError();
  }

  @override
  Future<Either<CleanFailure, IList<TaskData>>> getTasks() async {
    final data = await api.get(
        fromData: (data) =>
            List<TaskData>.from((data as List).map((e) => TaskData.fromMap(e)))
                .lock,
        endPoint: '/tasks/');
    return data;
  }

  @override
  Future<Option<CleanFailure>> updateTask(
      CreateUpdateTaskBody body, int taskId) async {
    final data = await api.put(
        fromData: (data) => data,
        body: body.toMap(),
        endPoint: '/tasks/$taskId/');

    return data.fold((l) => some(l), (r) => none());
  }
}
