import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String date;

  @HiveField(3)
  late bool done;

  @HiveField(4)
  late bool local;

  @HiveField(5)
  late bool updated;

  @HiveField(6)
  late bool deleted;

  Task({
    required this.title,
    required this.date,
    required this.done,
    required this.local,
    required this.updated,
    required this.deleted,
  }) {
    id = const Uuid().v4();
  }

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        date = json['date'] as String,
        done = json['done'] == 1,
        local = json['local'] == 1,
        updated = json['updated'] == 1,
        deleted = json['deleted'] == 1;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'done': done ? 1 : 0,
      'local': local ? 1 : 0,
      'updated': updated ? 1 : 0,
      'deleted': deleted ? 1 : 0,
    };
  }
}
