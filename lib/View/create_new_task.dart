import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Riverpod/task_state.dart';
import 'package:todolist/View%20Models/notification_view_model.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';
import 'package:todolist/View/widgets/custom_text_field.dart';

class CreateNewTask extends ConsumerStatefulWidget {
  const CreateNewTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends ConsumerState<CreateNewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController dueTimeController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<FormState> _taskFormkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    return AlertDialog(
      content: SizedBox(
        child: SingleChildScrollView(
          child: Form(
            key: _taskFormkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create A new task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: titleController,
                  textColor: Theme.of(context).textTheme.bodySmall!.color!,
                  borderRadius: BorderRadius.circular(10),
                  textInputAction: TextInputAction.next,
                  hintText: "Task Title",
                  validator: (value) => _validateInput(value, "Task Title"),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: detailsController,
                  textColor: Theme.of(context).textTheme.bodySmall!.color!,
                  borderRadius: BorderRadius.circular(10),
                  textInputAction: TextInputAction.next,
                  hintText: "Task Details",
                  validator: (value) => _validateInput(value, "Task Details"),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: scrSize.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "Due Date",
                          readOnly: true,
                          textSize: 12,
                          textColor:
                              Theme.of(context).textTheme.bodySmall!.color!,
                          borderRadius: BorderRadius.circular(10),
                          textInputAction: TextInputAction.next,
                          onTextFieldTap: () async => await onDatePressed(),
                          keyboardType: TextInputType.datetime,
                          suffixIcon: const Icon(Icons.calendar_month_rounded),
                          controller: dueDateController,
                          validator: (value) =>
                              _validateInput(value, "Date Selector"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          hintText: "04:00 PM",
                          readOnly: true,
                          textSize: 12,
                          textColor:
                              Theme.of(context).textTheme.bodySmall!.color!,
                          borderRadius: BorderRadius.circular(10),
                          onTextFieldTap: () async =>
                              await onTimePressed(context),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: const Icon(Icons.access_time),
                          controller: dueTimeController,
                          validator: (value) =>
                              _validateInput(value, "Time Selector"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextButton(
                  text: "Create new Task",
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    if (_taskFormkey.currentState!.validate()) {
                      _taskFormkey.currentState!.save();
                      selectedDate = selectedDate.copyWith(
                        hour: selectedTime.hour,
                        minute: selectedTime.minute,
                      );
                      TaskModel task = TaskModel(
                        title: titleController.text,
                        details: detailsController.text,
                        creationTime: DateTime.now().millisecondsSinceEpoch,
                        dueDate: selectedDate.millisecondsSinceEpoch,
                        pinned: false,
                        isOnline: true,
                        isArchived: false,
                      );
                      NotificationViewModel(context).scheduleNotification(
                        schedule: selectedDate,
                        id: int.tryParse(DateFormat("ddmmyyhhmm")
                                .format(selectedDate)) ??
                            001,
                        title: titleController.text,
                        body: detailsController.text,
                      );
                      ref
                          .read(taskNotifier.notifier)
                          .createTaskLocalNotifier(task);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateInput(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field is required.';
    }
    return null;
  }

  Future<void> onDatePressed() async {
    DateTime? selectedDateN = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDateN != null) {
      selectedDate = selectedDateN;
    }
    dueDateController.text = DateFormat("dd/MM/yyyy").format(selectedDate);
  }

  Future<void> onTimePressed(BuildContext context) async {
    TimeOfDay? tempTime;
    tempTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    selectedTime = tempTime!;
    if (context.mounted) {
      dueTimeController.text = selectedTime.format(context);
    }
  }
}
