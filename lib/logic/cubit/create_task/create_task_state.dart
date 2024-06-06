part of 'create_task_cubit.dart';

@immutable
sealed class CreateTaskState {
  final String error;

  const CreateTaskState({this.error = ''});
}

final class CreateTaskActive extends CreateTaskState {}

final class CreateTaskInactive extends CreateTaskState {}

final class CreateTaskLocalLoading extends CreateTaskState {}

final class CreateTaskLocalSuccess extends CreateTaskState {}

final class CreateTaskLocalError extends CreateTaskState {

  const CreateTaskLocalError({required String error});
}

final class CreateTaskRemoteLoading extends CreateTaskState {}

final class CreateTaskRemoteSuccess extends CreateTaskState {}

final class CreateTaskRemoteError extends CreateTaskState {

  const CreateTaskRemoteError({required String error});
}
