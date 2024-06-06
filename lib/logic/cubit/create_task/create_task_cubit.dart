import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:task/data/models/task.dart';
import 'package:task/data/repositories/add_task_repo.dart';
import 'package:task/logic/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/logic/cubit/internet/internet_cubit.dart';

import '../../../core/constants.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this._addTaskRemote) : super(CreateTaskInactive());
  final AddTaskRepo _addTaskRemote;

  //handling the Create task widget showing on the screen
  bool _isCreateTask = false;
  void changeIsCreateTask() {
    if (_isCreateTask) {
      _isCreateTask = false;
      emit(CreateTaskInactive());
    } else {
      _isCreateTask = true;
      emit(CreateTaskActive());
    }
  }


  void addTask({
    required GetTasksCubit getTasksCubit,
    required InternetCubit internetCubit,
    required String title,
    required String date,
  }) async {
    Task task = Task(
      title: title,
      date: date,
      done: false,
      local: false,
      updated: false,
      deleted: false,
    );
    getTasksCubit.newTask = task;
    //check if the there is internet connection
    if (internetCubit.state is ConnectedState) {
      // add to the remote server
      try {
        emit(CreateTaskRemoteLoading());
        await _addTaskRemote.addTask(task);
        emit(CreateTaskRemoteSuccess());
      } on FirebaseException catch (error) {
        emit(CreateTaskRemoteError(error: error.message!));
      }
    } 
    // if there is no internet connection
    else if (internetCubit.state is NotConnectedState) {
      // mark the task as local
      task.local = true;
    }
    // add to the local database
    try {
      emit(CreateTaskLocalLoading());
      var tasksBox = Hive.box<Task>(Strings.taskBox);
      await tasksBox.put(task.id, task);
      emit(CreateTaskLocalSuccess());
      getTasksCubit.changeFilter(TaskFilter.all);
    } catch (error) {
      getTasksCubit.deletedTask = task;
      emit(CreateTaskLocalError(error: error.toString()));
    }
    _isCreateTask = false;
  }
}
