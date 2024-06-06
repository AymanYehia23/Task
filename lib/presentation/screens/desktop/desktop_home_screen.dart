import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/logic/cubit/create_task/create_task_cubit.dart';
import 'package:task/presentation/widgets/create_task.dart';
import 'package:task/presentation/widgets/task_card.dart';

import '../../../logic/cubit/get_tasks/get_tasks_cubit.dart';
import '../../../logic/cubit/internet/internet_cubit.dart';
import '../../widgets/filter_button.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is ConnectedState) {
            context.read<GetTasksCubit>().getRemoteTasks();
          } else {
            context.read<GetTasksCubit>().getLocalTasks();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 61.h),
          child: BlocBuilder<GetTasksCubit, GetTasksState>(
            builder: (context, state) {
              final taskFilter = context.read<GetTasksCubit>();
              return Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                          InkWell(
                            onTap: context
                                .read<CreateTaskCubit>()
                                .changeIsCreateTask,
                            child: SvgPicture.asset(
                              'assets/images/add.svg',
                              width: 60.w,
                              height: 60.h,
                            ),
                          ),
                        ],
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
                      SizedBox(height: 50.h,),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 4,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          itemCount: state.tasks.length,
                          itemBuilder: (ctx, index) => TaskCard(
                            task: state.tasks[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<CreateTaskCubit, CreateTaskState>(
                    builder: (context, state) {
                      if (state is CreateTaskActive) {
                        return Center(child: CreateTask());
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
