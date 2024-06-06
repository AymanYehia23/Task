part of 'delete_task_cubit.dart';

@immutable
sealed class DeleteTaskState {
  final String error;

  const DeleteTaskState({this.error = ''});
}

final class DeleteTaskInitial extends DeleteTaskState {}

final class DeleteTaskLocalLoading extends DeleteTaskState {}

final class DeleteTaskLocalSuccess extends DeleteTaskState {}

final class DeleteTaskLocalError extends DeleteTaskState {
  const DeleteTaskLocalError({required String error});
}

final class DeleteTaskRemoteLoading extends DeleteTaskState {}

final class DeleteTaskRemoteSuccess extends DeleteTaskState {}

final class DeleteTaskRemoteError extends DeleteTaskState {
  const DeleteTaskRemoteError({required String error});
}
