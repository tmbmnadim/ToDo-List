import 'package:flutter/material.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';

class DeleteTaskDialog extends StatelessWidget {
  final Function() onDelete;
  const DeleteTaskDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Delete Task?",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        "Delete Task?",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        CustomTextButton(
          width: 100,
          height: 50,
          color: Colors.red.shade900,
          textColor: Colors.white,
          text: "Delete",
          onTap: onDelete,
        ),
        CustomTextButton(
          width: 100,
          height: 50,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          text: "Cancel",
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
