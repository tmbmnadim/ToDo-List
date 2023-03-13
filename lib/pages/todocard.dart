import 'package:flutter/material.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({super.key});

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NO DON'T"),
      ),
      body: Container(
        height: 915,
        width: 412,
        color: Color.fromARGB(255, 51, 247, 188),
        child: Container(
          color: Colors.white,
          height: 10,
          width: 30,
        ),
      ),
    );
  }
}
