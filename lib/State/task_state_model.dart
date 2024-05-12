import 'package:flutter/material.dart';

class TaskStateModel extends ChangeNotifier {
  // List<TaskModel> allTasks = [];
  int testVar = 0;

  void getAllTasks() {
    testVar += 1;
    notifyListeners();
  }
}
