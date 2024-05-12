import 'package:flutter/material.dart';
import 'package:todolist/Models/task_model.dart';

class TaskStateModel extends ChangeNotifier {
  // List<TaskModel> allTasks = [];
  int testVar = 0;

  void getAllTasks() {
    testVar += 1;
    notifyListeners();
  }
}
