import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'create_task_dialog_box.dart';

class UtilManager {
  UtilManager({
    required this.selectedDate,
    required this.screenHeight,
    required this.screenWidth,
  });
  DateTime? selectedDate;
  final double screenHeight;
  final double screenWidth;
  final _toDoListMem = Hive.box('taskBox');
  final _basicStates = Hive.box("stateBox");

  // Picking a date from calender.
  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001, 1, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      selectedDate = DateTime(
        picked.toLocal().year,
        (picked.toLocal().month),
        (picked.toLocal().day),
        (DateTime.now().hour),
        (DateTime.now().minute),
        (DateTime.now().second),
      );
    }
    return selectedDate;
  }

  Widget dayNightSwitcher(Function(void) setState){
    return GestureDetector(
      onTap: () {
        _basicStates.put(
            "darkLightMode", _basicStates.get("darkLightMode") == 1 ? 0 : 1);
        setState;
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: _basicStates.get("darkLightMode") == 0
              ? Tween<double>(begin: 1, end: 0.75).animate(anim)
              : Tween<double>(begin: 0.75, end: 1).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: _basicStates.get("darkLightMode") == 0
            ? const Icon(
          Icons.light_mode,
          key: ValueKey("lightMode"),
        )
            : const Icon(
          Icons.dark_mode,
          key: ValueKey("darkMode"),
        ),
      ),
    );
  }

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

  Color colorSelector({int index = 0}) {
    Color dateColor = Colors.green;
    // If "All Tasks" is not selected
    if (_basicStates.get("allTasks") == 0) {
      // If that date is selected
      if (selectedDate?.toLocal().day == index + 1) {
        dateColor = _basicStates.get("darkLightMode") == 0
            ? Colors.greenAccent // If Dark Mode is enabled
            : Colors.green.shade900; // If Dark Mode is disabled
      } else {
        dateColor = _basicStates.get("darkLightMode") == 0
            ? Colors.green.shade800 // If Dark Mode is enabled
            : Colors.green.shade500; // If Dark Mode is disabled
      }
    } else {
      // If "All Tasks" is selected
      dateColor = _basicStates.get("darkLightMode") == 0
          ? Colors.green.shade800
          : Colors.green.shade500;
    }

    return dateColor;
  }

  double widthSelector(int index, double screenHeight) {
    double selectedWidth = (screenHeight * 8) / 100;
    // If "All Tasks" is not selected
    if (_basicStates.get("allTasks") == 0) {
      selectedWidth = selectedDate?.toLocal().day == index + 1
          ? (screenHeight * 12) / 100
          : (screenHeight * 8) / 100;
    } else {
      // If "All Tasks" is selected
      selectedWidth = (screenHeight * 8) / 100;
    }

    return selectedWidth;
  }

  Widget dailyTaskSelector({
    required int index,
    required Function()? onTap,
    required String weekDay,
  }) {
    return GestureDetector(
      key: ValueKey("$index"),
      onTap: onTap,
      child: AnimatedContainer(
        // Day View
        duration: const Duration(milliseconds: 100),
        alignment: Alignment.center,
        height: (screenHeight * 8) / 100,
        width: widthSelector(index, screenHeight),
        decoration: BoxDecoration(
          color: colorSelector(index: index),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: [
            // Days of current month
            Container(
              alignment: Alignment.center,
              height: (screenHeight * 5) / 100,
              child: Text(
                "${index + 1}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // Weekday
            Container(
              alignment: Alignment.center,
              height: (screenHeight * 3) / 100,
              child: Text(
                weekDay,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Selecting a greeting according to current time.
  String greetingsUpdater(int runningHour) {
    String greeting = "Good Morning";
    if (runningHour < 12 && runningHour >= 5) {
      greeting = "Good Morning,";
    }
    if (runningHour >= 12 && runningHour < 17) {
      greeting = "Good Afternoon,";
    }
    if (runningHour >= 17 && runningHour < 5) {
      greeting = "Good Evening,";
    }
    return greeting;
  }

}

// todo_list_page.dart file code

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

// Color colorSelector(int index) {
//   Color dateColor = Colors.green;
//   // If "All Tasks" is not selected
//   if (_basicStates.get("allTasks") == 0) {
//     // If that date is selected
//     if (selectedDate?.toLocal().day == index + 1) {
//       dateColor = _basicStates.get("darkLightMode") == 1
//           ? Colors.greenAccent
//           : Colors.green.shade900;
//     } else {
//       dateColor = _basicStates.get("darkLightMode") == 1
//           ? Colors.green.shade800
//           : Colors.green.shade500;
//     }
//   } else {
//     // If "All Tasks" is selected
//     dateColor = _basicStates.get("darkLightMode") == 1
//         ? Colors.green.shade800
//         : Colors.green.shade500;
//   }
//
//   return dateColor;
// }
//
// double widthSelector(int index, double screenHeight) {
//   double selectedWidth = (screenHeight * 8) / 100;
//   // If "All Tasks" is not selected
//   if (_basicStates.get("allTasks") == 0) {
//     selectedWidth = selectedDate?.toLocal().day == index + 1
//         ? (screenHeight * 12) / 100
//         : (screenHeight * 8) / 100;
//   } else {
//     // If "All Tasks" is selected
//     selectedWidth = (screenHeight * 8) / 100;
//   }
//
//   return selectedWidth;
// }

// GestureDetector(
//   key: ValueKey("$dayIndex"),
//   onTap: () {
//     selectedDate = DateTime(
//       (selectedDate?.toLocal().year as int),
//       (selectedDate?.toLocal().month as int),
//       (dayIndex + 1),
//       (selectedDate?.toLocal().hour as int),
//       (selectedDate?.toLocal().minute as int),
//       (selectedDate?.toLocal().second as int),
//     );
//
//     _basicStates.put("allTasks", 0);
//
//     // This is used to select first day of selected month.
//     dayUpdater(selectedDate);
//     selectedTask = tdb.taskSelector(selectedDate);
//     setState(() {});
//   },
//   child: Container(
//     // Day View
//     alignment: Alignment.center,
//     height: (screenHeight * 8) / 100,
//     width: widthSelector(dayIndex, screenHeight),
//     color: colorSelector(dayIndex),
//     child: Column(
//       children: [
//         // Days of current month
//         Container(
//           alignment: Alignment.center,
//           height: (screenHeight * 5) / 100,
//           child: Text(
//             "${dayIndex + 1}",
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//
//         // Weekday
//         Container(
//           alignment: Alignment.center,
//           height: (screenHeight * 3) / 100,
//           child: Text(
//             weekDays[(((firstDayOfMonth
//                             ?.toLocal()
//                             .weekday as int) -
//                         1) +
//                     dayIndex) %
//                 7],
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
