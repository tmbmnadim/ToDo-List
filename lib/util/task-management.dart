import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../pages/create-task-dialog-box.dart';

class TaskManager {
  final _toDoListMem = Hive.box('taskBox');
  final _basicStates = Hive.box("stateBox");

  List<List> taskSelector(DateTime? selectedDateTask) {
    List<List> selectedTask = [];
    // Storing current date
    String currentDate =
        "${selectedDateTask?.day}/${selectedDateTask?.month}/${selectedDateTask?.year}";

    if (_basicStates.get("allTasks") == 0) {
      for (int i = 0; i < _toDoListMem.length; i++) {
        if (_toDoListMem.getAt(i)[3] == currentDate) {
          selectedTask.add(_toDoListMem.getAt(i));
        }
      }
    } else {
      for (int i = 0; i < _toDoListMem.length; i++) {
        selectedTask.add(_toDoListMem.getAt(i));
      }
    }
    return selectedTask;
  }

  void createNewTask({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController taskController,
    required Function()? onSave,
    required Function()? onDatePick,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return CreateTaskDialogBox(
            titleController: titleController,
            taskController: taskController,
            onDatePick: onDatePick,
            onSave: onSave,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void clearTasks(String currentDate) {
    List tempList = [];
    List tempListRev = [];
    if (_basicStates.get("allTasks") == 0) {
      for (int i = 0; i < _toDoListMem.length; i++) {
        if (_toDoListMem.getAt(i)[3] == currentDate) {
          tempList.add(i);
        }
      }
      tempListRev = List.from(tempList.reversed);
      for (int j = 0; j < tempListRev.length; j++) {
        _toDoListMem.deleteAt(tempListRev[j]);
      }
    } else {
      _toDoListMem.clear();
    }
  }

  void deleteTask(List<List> selectedTask, int index) {
    for (int i = 0; i < _toDoListMem.length; i++) {
      if (_toDoListMem.getAt(i)[4] == selectedTask[index][4]) {
        _toDoListMem.deleteAt(i);
        break;
      }
    }
  }
}

// todo-list-page.dart file code

// Selecting today's task
// List<List> taskSelector(DateTime? selectedDateTask) {
//   List<List> selectedTask = [];
//   // Storing current date
//   String currentDate =
//       "${selectedDateTask?.day}/${selectedDateTask?.month}/${selectedDateTask?.year}";
//
//   if (_basicStates.get("allTasks") == 0) {
//     for (int i = 0; i < _toDoListMem.length; i++) {
//       if (_toDoListMem.getAt(i)[3] == currentDate) {
//         selectedTask.add(_toDoListMem.getAt(i));
//       }
//     }
//   } else {
//     for (int i = 0; i < _toDoListMem.length; i++) {
//       selectedTask.add(_toDoListMem.getAt(i));
//     }
//   }
//   return selectedTask;
// }

// void createNewTask() {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return CreateTaskDialogBox(
//           titleController: _titleController,
//           taskController: _taskController,
//           onDatePick: () {
//             selectDate(context);
//
//             // This is used to select first day of selected month.
//             dayUpdater(selectedDate);
//             selectedTask = tdb.taskSelector(selectedDate);
//             setState(() {});
//           },
//           onSave: () {
//             setState(() {
//               _toDoListMem.put(_toDoListMem.length, [
//                 false,
//                 _titleController.value.text,
//                 _taskController.value.text,
//                 "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}"
//               ]);
//             });
//             _titleController.clear();
//             _taskController.clear();
//             Navigator.of(context).pop();
//           },
//           onCancel: () => Navigator.of(context).pop(),
//         );
//       });
// }

// void clearTasks() {
//   List tempList = [];
//   List tempListRev = [];
//   if (_basicStates.get("allTasks") == 0) {
//     for (int i = 0; i < _toDoListMem.length; i++) {
//       if (_toDoListMem.getAt(i)[3] ==
//           "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}") {
//         tempList.add(i);
//       }
//     }
//     tempListRev = List.from(tempList.reversed);
//     for (int j = 0; j < tempListRev.length; j++) {
//       _toDoListMem.deleteAt(tempListRev[j]);
//     }
//   } else {
//     _toDoListMem.clear();
//   }
// }
