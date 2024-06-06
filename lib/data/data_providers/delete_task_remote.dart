import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/repositories/delete_task_repo.dart';

class DeleteTaskRemote extends DeleteTaskRepo {
  @override
  Future<void> deleteTask(String id) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }
}
