import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard(
      {super.key,
      this.valueKey,
      this.title = "No Title!",
      this.taskToDo = "No Task!",
      required this.taskDate,
      this.onEditButton,
      this.onDeleteButton,
      this.checkboxOnChanged,
      required this.isChecked,
      required this.screenWidth,
      required this.screenHeight});
  final ValueKey? valueKey;
  final void Function(bool?)? checkboxOnChanged;
  final bool? isChecked;
  final String title;
  final void Function()? onEditButton;
  final void Function()? onDeleteButton;
  final String taskToDo;
  final String taskDate;
  final double screenWidth;
  final double screenHeight;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  final _basicStates = Hive.box('stateBox');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: widget.valueKey,
        width: widget.screenWidth - 16,
        height: 140,
        decoration: BoxDecoration(
          color: _basicStates.get("darkLightMode") == 1?Colors.green.shade800:Colors.green.shade500,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(0, 20),
              blurRadius: 4,
              spreadRadius: -9,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              height: 150,
              width: 50,
              decoration: BoxDecoration(
                color: _basicStates.get("darkLightMode") == 1?Colors.lightGreen:Colors.lightGreen.shade400,
              ),
              child: Transform.scale(
                scale: 1.9,
                child: Checkbox(
                  // Here is the checkbox
                  activeColor: Colors.black,
                  fillColor: const MaterialStatePropertyAll(Colors.white),
                  checkColor: Colors.black87,
                  value: widget.isChecked,
                  onChanged: widget.checkboxOnChanged,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Grape Nuts",
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.taskToDo,
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: "Grape Nuts",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.taskDate,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 150,
              width: 50,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: widget.onEditButton,
                    child: Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: const Icon(
                        Icons.edit,
                        size: 25,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onDeleteButton,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 24),
                      child: const Icon(
                        Icons.delete,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
