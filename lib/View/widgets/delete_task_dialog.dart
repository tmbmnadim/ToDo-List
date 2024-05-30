import 'package:flutter/material.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';

class DeleteTaskDialog extends StatelessWidget {
  final Function() onPress;
  final String title;
  final String buttonTitle;
  final String subTitle;
  final Color buttonColor;
  const DeleteTaskDialog({
    super.key,
    required this.onPress,
    required this.title,
    required this.buttonTitle,
    required this.subTitle,
    this.buttonColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        CustomTextButton(
          width: 120,
          height: 50,
          color: buttonColor,
          textColor: Colors.white,
          text: buttonTitle,
          onTap: onPress,
        ),
        CustomTextButton(
          width: 120,
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
