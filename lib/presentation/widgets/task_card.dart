import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/logic/cubit/internet/internet_cubit.dart';
import 'package:task/logic/cubit/update_task/update_task_cubit.dart';
import 'package:task/logic/cubit/delete_task/delete_task_cubit.dart';
import 'package:task/logic/cubit/get_tasks/get_tasks_cubit.dart';

import '../../data/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      direction: Platform.isWindows ? DismissDirection.vertical : DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<DeleteTaskCubit>().deleteTask(
              internetCubit: context.read<InternetCubit>(),
              getTasksCubit: context.read<GetTasksCubit>(),
              task: task,
            );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: InkWell(
          onTap: () {
            context.read<UpdateTaskCubit>().updateTask(
                  task: task,
                  internetCubit: context.read<InternetCubit>(),
                );
          },
          child: SizedBox(
            width: 323.w,
            height: 70.h,
            child: Card(
              margin: const EdgeInsets.all(0),
              color: Colors.white,
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            'Due Date: ${task.date}',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<UpdateTaskCubit, UpdateTaskState>(
                      builder: (context, state) {
                        return SvgPicture.asset(
                          task.done
                              ? 'assets/images/done.svg'
                              : 'assets/images/not_done.svg',
                          fit: BoxFit.contain,
                          width: 37.w,
                          height: 37.h,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
