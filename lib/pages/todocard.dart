import 'package:flutter/material.dart';
import 'package:todolist/data/listsvalue.dart';

class ToDoCard extends StatefulWidget {
  ToDoCard(
      {super.key,
      this.valueKey,
      this.title = "No Title!",
      this.taskToDo = "No Task!",
      required this.taskDate,
      required this.isCheckedbox,
      required this.screenWidth,
      required this.screenHeight});
  ValueKey? valueKey;
  bool? isCheckedbox;
  String title;
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
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(5, 5),
              blurRadius: 4,
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
              color: Colors.lightGreen,
              child: Transform.scale(
                scale: 1.9,
                child: Checkbox(
                  activeColor: Colors.black,
                  fillColor: const MaterialStatePropertyAll(Colors.white),
                  checkColor: Colors.black87,
                  value: widget.isCheckedbox,
                  onChanged: (index) {
                    widget.isCheckedbox = index!;
                    setState(() {});
                  },
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
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
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
