import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  final toDoListMem = Hive.box('taskbox');
// Create new task
  void writeTask(int keyValue, List taskData) async {
    await toDoListMem.put(keyValue, taskData);
  }

  void readTask(int keyValue) async {
    await toDoListMem.get(keyValue);
  }

  void deleteTask() async {
    await toDoListMem.delete(0);
  }
//
// List<List> toDoList = [
//   [true, "123456789012345678901234567890", "1/3/2023"],
//   [false, "Second Task", "1/3/2023"],
//   [true, "TITLE", "1/3/2023"],
//   [true, "TITLE", "2/3/2023"],
//   [true, "TITLE", "3/3/2023"],
//   [true, "This is a test title!", "15/3/2023"],
// ];
}
