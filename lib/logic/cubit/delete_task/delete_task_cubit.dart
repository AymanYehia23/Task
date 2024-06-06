import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:task/data/repositories/delete_task_repo.dart';
import 'package:task/logic/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/logic/cubit/internet/internet_cubit.dart';

import '../../../core/constants.dart';
import '../../../data/models/task.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit(
    this._deleteTaskRemote,
  ) : super(DeleteTaskInitial());
  final DeleteTaskRepo _deleteTaskRemote;

  void deleteTask(
      {required InternetCubit internetCubit,
      required GetTasksCubit getTasksCubit,
      required Task task}) async {
    getTasksCubit.deletedTask = task;
    //check if the there is internet connection
    if (internetCubit.state is ConnectedState) {
    // delete from the remote server
      try {
        emit(DeleteTaskRemoteLoading());
        await _deleteTaskRemote.deleteTask(task.id);
        emit(DeleteTaskRemoteSuccess());
      } on FirebaseException catch (error) {
        emit(DeleteTaskRemoteError(error: error.message!));
      }
    } 
    // if there is no internet connection
    else if (internetCubit.state is NotConnectedState) {
      // mark the task as deleted
      task.deleted = true;
    }
    // delete from the local database
    try {
      emit(DeleteTaskLocalLoading());
      var tasksBox = Hive.box<Task>(Strings.taskBox);
      if (task.deleted) {
        await tasksBox.put(task.id, task);
      } else {
        await tasksBox.delete(task.id);
        emit(DeleteTaskLocalSuccess());
      }
    } catch (error) {
      emit(DeleteTaskLocalError(error: error.toString()));
    }
    getTasksCubit.changeFilter(TaskFilter.all);
  }
}
