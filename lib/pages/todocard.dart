import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist/data/listsvalue.dart';

class ToDoCard extends StatefulWidget {
  ToDoCard(
      {super.key,
      this.valueKey,
      this.title = "No Title!",
      this.taskToDo = "No Task!",
      required this.taskDate,
      this.onEditButton,
      this.onDeleteButton,
      this.checkboxOnChanged,
      required this.isCheckedbox,
      required this.screenWidth,
      required this.screenHeight});
  ValueKey? valueKey;
  void Function(bool?)? checkboxOnChanged;
  bool? isCheckedbox;
  String title;
  void Function()? onEditButton;
  void Function()? onDeleteButton;
  String taskToDo;
  String taskDate;
  final double screenWidth;
  final double screenHeight;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: widget.valueKey,
        width: widget.screenWidth - 16,
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.green,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 43, 100, 46),
              Color.fromARGB(255, 34, 78, 36),
              Colors.green,
            ],
            stops: [0.1, 0.15, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              alignment: Alignment.topCenter,
              height: 150,
              width: 50,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 88, 124, 47),
                    Color.fromARGB(255, 71, 100, 38),
                    Colors.lightGreen,
                  ],
                  stops: [0.1, 0.15, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Transform.scale(
                scale: 1.9,
                child: Checkbox(
                  // Here is the checkbox
                  activeColor: Colors.black,
                  fillColor: const MaterialStatePropertyAll(Colors.white),
                  checkColor: Colors.black87,
                  value: widget.isCheckedbox,
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
                      padding: const EdgeInsets.only(top: 24, left: 8),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 24),
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
