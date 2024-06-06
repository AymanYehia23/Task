import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/logic/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/logic/cubit/internet/internet_cubit.dart';
import 'package:task/presentation/widgets/task_button.dart';
import 'package:task/presentation/widgets/task_form.dart';

import '../../logic/cubit/create_task/create_task_cubit.dart';

class CreateTask extends StatelessWidget {
  CreateTask({super.key});
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  final _dueDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void submit() async {
      if (_globalKey.currentState!.validate()) {
        context.read<CreateTaskCubit>().addTask(
            internetCubit: context.read<InternetCubit>(),
            getTasksCubit: context.read<GetTasksCubit>(),
            title: _taskTitleController.text,
            date: _dueDateController.text);
      }
    }

    return Container(
      height: 262.h,
      margin: EdgeInsets.symmetric(horizontal: 9.w),
      padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 10.h),
      width: 343.w,
      decoration: BoxDecoration(
        border: Platform.isWindows
            ? Border.all(
                color: const Color.fromRGBO(78, 203, 113, 0.25),
                width: 3,
              )
            : null,
        borderRadius: Platform.isWindows
            ? BorderRadius.circular(10.r)
            : BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
        color: Colors.white,
        boxShadow: Platform.isWindows
            ? null
            : const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 6.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    0.0,
                    -5.0,
                  ),
                ),
              ],
      ),
      child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
        builder: (context, state) {
          if (state is CreateTaskRemoteLoading ||
              state is CreateTaskLocalLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state is CreateTaskRemoteError || state is CreateTaskLocalError) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed:
                        context.read<CreateTaskCubit>().changeIsCreateTask,
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromRGBO(242, 78, 30, 1),
                    ),
                  ),
                ],
              ),
              Text(
                'Create New Task',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              TaskForm(
                formKey: _globalKey,
                taskTitleController: _taskTitleController,
                dueDateController: _dueDateController,
              ),
              const Spacer(),
              TaskButton(
                label: 'Save Task',
                onTap: submit,
              ),
            ],
          );
        },
      ),
    );
  }
}
