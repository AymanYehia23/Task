part of 'update_task_cubit.dart';

@immutable
sealed class UpdateTaskState {
  final String error;

  const UpdateTaskState({this.error = ''});
}

final class UpdateTaskInitial extends UpdateTaskState {}

final class UpdateTaskLocalLoading extends UpdateTaskState {}

final class UpdateTaskLocalSuccess extends UpdateTaskState {}

final class UpdateTaskLocalError extends UpdateTaskState {
  const UpdateTaskLocalError({required String error});
}

final class UpdateTaskRemoteLoading extends UpdateTaskState {}

final class UpdateTaskRemoteSuccess extends UpdateTaskState {}

final class UpdateTaskRemoteError extends UpdateTaskState {
  const UpdateTaskRemoteError({required String error});
}
