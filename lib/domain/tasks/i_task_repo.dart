import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:simple_todo_app/domain/tasks/create_update_task_body.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';

abstract class ITaskRepo {
  Future<Option<CleanFailure>> createTask(CreateUpdateTaskBody body);
  Future<Option<CleanFailure>> updateTask(CreateUpdateTaskBody body);
  Future<Option<CleanFailure>> deleteTasks(int taskId);
  Future<Either<CleanApi, IList<TaskData>>> getTasks();
}
