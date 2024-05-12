import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class CreateDeleteTaskButtons extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final List<BoxShadow>? boxShadow;
  final Function() onCreate;
  final Function() onDelete;
  const CreateDeleteTaskButtons({
    super.key,
    required this.height,
    required this.width,
    required this.onCreate,
    required this.onDelete,
    this.boxShadow,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextButton(
              text: "Create Task",
              color: color,
              borderRadiusValue: const BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
              height: 50,
              textColor: Colors.white,
              onTap: onCreate,
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: CustomTextButton(
              text: "Delete Task",
              color: color,
              borderRadiusValue: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              height: 50,
              textColor: Colors.white,
              onTap: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
