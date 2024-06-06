import 'package:task/data/models/task.dart';

abstract class AddTaskRepo {
  Future<void> addTask(Task task);
}
