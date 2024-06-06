import '../models/task.dart';

abstract class GetTasksRepo {
  Future<List<Task>> getTasks();
}
