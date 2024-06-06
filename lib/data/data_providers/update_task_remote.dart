import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/task.dart';
import 'package:task/data/repositories/update_task_repo.dart';

class UpdateTaskRemote implements UpdateTaskRepo {
  @override
  Future<void> updateTask(Task task) async {
    FirebaseFirestore.instance.collection('tasks').doc(task.id).update(
          task.toJson(),
        );
  }
}
