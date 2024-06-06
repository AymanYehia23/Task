import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

import 'package:task/data/repositories/add_task_repo.dart';
import 'package:task/data/repositories/delete_task_repo.dart';
import 'package:task/data/repositories/get_tasks_repo.dart';
import 'package:task/data/repositories/update_task_repo.dart';

import '../../../core/constants.dart';
import '../../../data/models/task.dart';

part 'get_tasks_state.dart';

enum TaskFilter {
  all,
  notDone,
  done,
}

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit(
    this._getTasksRemote,
    this._addTaskRemote,
    this._deleteTaskRemote,
    this._updateTaskRemote,
  ) : super(const GetTasksInitialState());

  final GetTasksRepo _getTasksRemote;
  final DeleteTaskRepo _deleteTaskRemote;
  final AddTaskRepo _addTaskRemote;
  final UpdateTaskRepo _updateTaskRemote;

  List<Task> _tasks = [];

  set newTask(Task task) {
    _tasks.add(task);
  }

  set deletedTask(Task task) {
    _tasks.remove(task);
  }

  void getRemoteTasks() async {
    try {
      //synchronize the remote server with the local database first
      await _sync();
      emit(const GetTasksRemoteLoading());
      _tasks = await _getTasksRemote.getTasks();
      emit(const GetTasksRemoteSuccess());
      var tasksBox = Hive.box<Task>(Strings.taskBox);
      //delete all the local database tasks
      await tasksBox.clear();
      //synchronize local database with the remote server data
      for (final task in _tasks) {
        await tasksBox.put(task.id, task);
      }
    } on FirebaseException catch (error) {
      getLocalTasks();
      emit(GetTasksRemoteError(error: error.message!));
    }
    changeFilter(TaskFilter.all);
  }

  void getLocalTasks() async {
    var tasksBox = Hive.box<Task>(Strings.taskBox);
    try {
      emit(const GetTasksLocalLoading());
      _tasks = tasksBox.values.toList();
      emit(const GetTasksLocalSuccess());
    } catch (error) {
      emit(GetTasksLocalError(error: error.toString()));
    }
    changeFilter(TaskFilter.all);
  }

  //synchronize the tasks in the local database with the remote server
  Future<void> _sync() async {
    getLocalTasks();
    emit(SyncTasksLoading());
    for (final task in _tasks) {
      if (task.deleted) {
        await _deleteTaskRemote.deleteTask(task.id);
      }
      if (task.local) {
        task.local = false;
        await _addTaskRemote.addTask(task);
      }
      if (task.updated) {
        task.updated = false;
        await _updateTaskRemote.updateTask(task);
      }
    }
    emit(SyncTasksSuccess());
  }

  void changeFilter(TaskFilter filter) {
    if (filter == TaskFilter.all) {
      emit(GetAllTasks(
        tasks: _tasks.where((task) => !task.deleted).toList(),
      ));
    } else if (filter == TaskFilter.notDone) {
      emit(GetNotDoneTasks(
        tasks: _tasks
            .where(
              (task) => (!task.done && !task.deleted),
            )
            .toList(),
      ));
    } else if (filter == TaskFilter.done) {
      emit(GetDoneTasks(
          tasks: _tasks
              .where(
                (task) => (task.done && !task.deleted),
              )
              .toList()));
    }
  }
}
