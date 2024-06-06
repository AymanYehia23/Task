import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/task.dart';
import 'package:task/data/repositories/add_task_repo.dart';

class AddTaskRemote implements AddTaskRepo {
  @override
  Future<void> addTask(Task task) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.id)
        .set(task.toJson());
  }
}
