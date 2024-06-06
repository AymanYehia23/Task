import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/logic/cubit/create_task/create_task_cubit.dart';
import 'package:task/logic/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/logic/cubit/internet/internet_cubit.dart';
import 'package:task/presentation/widgets/create_task.dart';

import '../../widgets/filter_button.dart';
import '../../widgets/task_button.dart';
import '../../widgets/task_card.dart';

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is ConnectedState) {
                  context.read<GetTasksCubit>().getRemoteTasks();
                } else {
                  context.read<GetTasksCubit>().getLocalTasks();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: BlocBuilder<GetTasksCubit, GetTasksState>(
                  builder: (context, state) {
                    final taskFilter = context.read<GetTasksCubit>();
                    if (state is GetTasksRemoteLoading ||
                        state is GetTasksLocalLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                    if (state is GetTasksRemoteError ||
                        state is GetTasksLocalError) {
                      return Center(
                        child: Text(
                          state.error,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: 30.sp,
                          ),
                        ),
                        Row(
                          children: [
                            FilterButton(
                              label: 'All',
                              isActive: state is GetAllTasks,
                              onTap: () {
                                taskFilter.changeFilter(TaskFilter.all);
                              },
                            ),
                            FilterButton(
                              label: 'Not Done',
                              isActive: state is GetNotDoneTasks,
                              onTap: () {
                                taskFilter.changeFilter(TaskFilter.notDone);
                              },
                            ),
                            FilterButton(
                              label: 'Done',
                              isActive: state is GetDoneTasks,
                              onTap: () {
                                taskFilter.changeFilter(TaskFilter.done);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (ctx, index) {
                              return TaskCard(
                                task: state.tasks[index],
                              );
                            },
                          ),
                        ),
                        TaskButton(
                          label: 'Create Task',
                          onTap: context
                              .read<CreateTaskCubit>()
                              .changeIsCreateTask,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<CreateTaskCubit, CreateTaskState>(
              builder: (context, state) {
                if (state is CreateTaskActive) {
                  return Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CreateTask(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
