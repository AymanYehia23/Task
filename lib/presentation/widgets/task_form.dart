import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    super.key,
    required this.formKey,
    required this.taskTitleController,
    required this.dueDateController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController taskTitleController;
  final TextEditingController dueDateController;
  @override
  TaskFormState createState() => TaskFormState();
}

class TaskFormState extends State<TaskForm> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      widget.dueDateController.text = DateFormat('EEE. d/M/yyyy').format(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.taskTitleController.clear();
    widget.dueDateController.clear();
  }

  @override
  void dispose() {
    widget.taskTitleController.dispose();
    widget.dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: const Color.fromRGBO(217, 217, 217, 0.2),
            ),
            child: TextFormField(
              controller: widget.taskTitleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(217, 217, 217, 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Task title',
              ),
              cursorColor: Theme.of(context).primaryColor,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task title can\'t be empty';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: const Color.fromRGBO(217, 217, 217, 0.2),
            ),
            child: TextFormField(
              controller: widget.dueDateController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(217, 217, 217, 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Due Date',
              ),
              cursorColor: Theme.of(context).primaryColor,
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Due Date can\'t be empty';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
