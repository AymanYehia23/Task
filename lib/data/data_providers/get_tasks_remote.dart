import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/task.dart';
import 'package:task/data/repositories/get_tasks_repo.dart';

class GetTasksRemote extends GetTasksRepo {
  @override
  Future<List<Task>> getTasks() async {
    final res = await FirebaseFirestore.instance.collection('tasks').get();
    return res.docs.map((doc) => Task.fromJson(doc.data())).toList();
  }
}
