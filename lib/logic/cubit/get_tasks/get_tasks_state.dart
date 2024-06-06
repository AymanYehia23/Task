part of 'get_tasks_cubit.dart';

@immutable
sealed class GetTasksState {
  final List<Task> tasks;
  final String error;
  const GetTasksState({this.tasks = const [], this.error = ''});
}

final class GetTasksInitialState extends GetTasksState {
  const GetTasksInitialState();
}

final class GetTasksLocalLoading extends GetTasksState {
  const GetTasksLocalLoading();
}

final class GetTasksLocalSuccess extends GetTasksState {
  const GetTasksLocalSuccess();
}

final class GetTasksLocalError extends GetTasksState {
  const GetTasksLocalError({required String error});
}

final class GetTasksRemoteLoading extends GetTasksState {
  const GetTasksRemoteLoading();
}

final class GetTasksRemoteSuccess extends GetTasksState {
  const GetTasksRemoteSuccess();
}

final class GetTasksRemoteError extends GetTasksState {
  const GetTasksRemoteError({required String error});
}

final class GetAllTasks extends GetTasksState {
  const GetAllTasks({required super.tasks});
}

final class GetDoneTasks extends GetTasksState {
  const GetDoneTasks({required super.tasks});
}

final class GetNotDoneTasks extends GetTasksState {
  const GetNotDoneTasks({required super.tasks});
}

final class SyncTasksLoading extends GetTasksState {}

final class SyncTasksSuccess extends GetTasksState {}


