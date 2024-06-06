import '../models/task.dart';

abstract class UpdateTaskRepo {
  Future<void> updateTask(Task task);
}
