import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:simple_todo_app/domain/tasks/create_update_task_body.dart';
import 'package:simple_todo_app/domain/tasks/i_task_repo.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';

class TaskRepo extends ITaskRepo {
  @override
  Future<Option<CleanFailure>> createTask(CreateUpdateTaskBody body) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<Option<CleanFailure>> deleteTasks(int taskId) {
    // TODO: implement deleteTasks
    throw UnimplementedError();
  }

  @override
  Future<Either<CleanFailure, IList<TaskData>>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<Option<CleanFailure>> updateTask(CreateUpdateTaskBody body) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
