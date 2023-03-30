import 'package:flutter/material.dart';

class CreateTaskDialogBox extends StatefulWidget {
  const CreateTaskDialogBox({
    Key? key,
    required this.titleController,
    required this.taskController,
    required this.onSave,
    required this.onCancel,
    required this.onDatePick,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController taskController;
  final Function()? onSave;
  final Function()? onCancel;
  final Function()? onDatePick;

  @override
  State<CreateTaskDialogBox> createState() => _CreateTaskDialogBoxState();
}

class _CreateTaskDialogBoxState extends State<CreateTaskDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green.shade300,
      content: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: widget.titleController,
              decoration: const InputDecoration(
                hintText: "Title of your task",
                filled: true,
                fillColor: Colors.white60,
              ),
              maxLength: 50,
            ),
            TextField(
              controller: widget.taskController,
              decoration: const InputDecoration(
                hintText: "Description",
                filled: true,
                fillColor: Colors.white60,
              ),
            ),
            IconButton(
              onPressed: widget.onDatePick,
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: widget.onSave,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: widget.onCancel,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
