import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:task/data/repositories/update_task_repo.dart';
import 'package:task/logic/cubit/internet/internet_cubit.dart';

import '../../../core/constants.dart';
import '../../../data/models/task.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit(this._updateTaskRemote) : super(UpdateTaskInitial());
  final UpdateTaskRepo _updateTaskRemote;
  void updateTask(
      {required InternetCubit internetCubit, required Task task}) async {
    task.done = !task.done;

    //check if the there is internet connection
    if (internetCubit.state is ConnectedState) {
      try {
        // update to the remote server
        emit(UpdateTaskRemoteLoading());
        await _updateTaskRemote.updateTask(task);
        emit(UpdateTaskRemoteSuccess());
      } on FirebaseException catch (error) {
        emit(UpdateTaskRemoteError(error: error.message!));
      }
    } 
    // if there is no internet connection
    else if (internetCubit.state is NotConnectedState) {
      // mark the task as updated
      task.updated = true;
    }
    // update to the local database
    try {
      emit(UpdateTaskLocalLoading());
      var tasksBox = Hive.box<Task>(Strings.taskBox);
      await tasksBox.put(task.id, task);
      emit(UpdateTaskLocalSuccess());
    } catch (error) {
      task.done = !task.done;
      emit(UpdateTaskLocalError(error: error.toString()));
    }
  }
}
