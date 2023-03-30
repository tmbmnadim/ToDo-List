import 'package:flutter/material.dart';
import 'package:todolist/pages/custom-button.dart';
import 'package:todolist/pages/todo-card.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../util/task-management.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    Key? key,
    required this.modeAction,
  }) : super(key: key);

  final Widget modeAction;
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _titleController = TextEditingController();
  final _taskController = TextEditingController();
  int monthValue = 8;
  DateTime? selectedDate = DateTime.now();
  DateTime? firstDayOfMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );
  List<String> monthName = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<String> weekDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  int firstWeekday = 0;
  bool isChecked = false;

  final _toDoListMem = Hive.box('taskBox');
  final _basicStates = Hive.box('stateBox');
  TaskManager tdb = TaskManager();
  List<List> selectedTask = [];

  Color colorSelector(int index) {
    Color dateColor = Colors.green;
    // If "All Tasks" is not selected
    if (_basicStates.get("allTasks") == 0) {
      // If that date is selected
      if (selectedDate?.toLocal().day == index + 1) {
        dateColor = _basicStates.get("darkLightMode") == 1
            ? Colors.greenAccent
            : Colors.green.shade900;
      } else {
        dateColor = _basicStates.get("darkLightMode") == 1
            ? Colors.green.shade800
            : Colors.green.shade500;
      }
    } else {
      // If "All Tasks" is selected
      dateColor = _basicStates.get("darkLightMode") == 1
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

  // Picking a date from calender.
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001, 1, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDate = DateTime(
          picked.toLocal().year,
          (picked.toLocal().month),
          (picked.toLocal().day),
          (DateTime.now().hour),
          (DateTime.now().minute),
          (DateTime.now().second),
        );
      });
    }
  }

  // Getting the first day of the month.
  void dayUpdater(DateTime? selectedDateIs) {
    firstDayOfMonth = DateTime(
      (selectedDateIs?.toLocal().year as int),
      (selectedDateIs?.toLocal().month as int),
      1,
    );
  }

  // Selecting a greeting according to current time.
  String greetingsUpdater(int runningHour) {
    String greeting = "Good Morning!";
    if (runningHour < 12 && runningHour >= 0) {
      greeting = "Good Morning!";
    }
    if (runningHour >= 12 && runningHour <= 24) {
      greeting = "Good Night!";
    }
    return greeting;
  }

  @override
  void initState() {
    selectedTask = tdb.taskSelector(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    selectedTask = tdb.taskSelector(selectedDate);
    String currentDate =
        "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}";
    String taskUniqueID =
        "${selectedDate?.day}${selectedDate?.month}${selectedDate?.year}"
        "${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}";
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            // Calender Icon Appbar
            onTap: () {
              selectDate(context);

              // This is used to select first day of selected month.
              dayUpdater(selectedDate);
              selectedTask = tdb.taskSelector(selectedDate);
              setState(() {});
            },
            child: const Icon(Icons.calendar_month),
          ),
          const SizedBox(
            width: 10,
          ),
          widget.modeAction,
          const SizedBox(
            width: 10,
          ),
        ],
        title: const Text("ToDo List"),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              height: (screenHeight * 35) / 100,
              width: screenWidth,
              color: const Color.fromRGBO(125, 125, 125, 0.25),
              child: Column(
                children: [
                  Container(
                    height: (screenHeight * 16) / 100,
                    width: screenWidth,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.bottomLeft,
                          height: (screenHeight * 8) / 100,
                          width: screenWidth,
                          child: Text(
                            greetingsUpdater(
                                selectedDate?.toLocal().hour as int),
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.centerLeft,
                          height: (screenHeight * 8) / 100,
                          width: screenWidth,
                          child: const Text(
                            "User Name!",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //MONTH View
                    height: (screenHeight * 8) / 100,
                    width: screenWidth,
                    color: _basicStates.get("darkLightMode") == 1
                        ? Colors.green.shade800
                        : Colors.green.shade500,
                    child: Row(
                      children: [
                        // Selects previous month
                        IconButton(
                          onPressed: () {
                            selectedDate = DateTime(
                              selectedDate?.toLocal().year as int,
                              (selectedDate?.toLocal().month as int) - 1,
                              (selectedDate?.toLocal().day as int),
                              (selectedDate?.toLocal().hour as int),
                              (selectedDate?.toLocal().minute as int),
                              (selectedDate?.toLocal().second as int),
                            );

                            // This is used to select first day of selected month.
                            dayUpdater(selectedDate);
                            selectedTask = tdb.taskSelector(selectedDate);
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),

                        // Shows selected month and year.
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight * 8) / 100,
                            child: Text(
                              "${monthName[(selectedDate?.toLocal().month as int) - 1]} ${selectedDate?.toLocal().year}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ),

                        // Selects next month.
                        IconButton(
                          onPressed: () {
                            selectedDate = DateTime(
                              selectedDate?.toLocal().year as int,
                              (selectedDate?.toLocal().month as int) + 1,
                              (selectedDate?.toLocal().day as int),
                              (selectedDate?.toLocal().hour as int),
                              (selectedDate?.toLocal().minute as int),
                              (selectedDate?.toLocal().second as int),
                            );

                            // This is used to select first day of selected month.
                            dayUpdater(selectedDate);
                            selectedTask = tdb.taskSelector(selectedDate);
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),

                  // A list of days of current month.
                  Container(
                    height: (screenHeight * 11) / 100,
                    width: screenWidth,
                    color: const Color.fromRGBO(125, 125, 125, 0.25),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              _basicStates.put("allTasks", 1);
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: _basicStates.get("allTasks") == 0
                                  ? (screenHeight * 8) / 100
                                  : (screenHeight * 12) / 100,
                              color: _basicStates.get("allTasks") == 0
                                  ? _basicStates.get("darkLightMode") == 1
                                      ? Colors.green.shade800
                                      : Colors.green.shade500
                                  : _basicStates.get("darkLightMode") == 1
                                      ? Colors.greenAccent
                                      : Colors.green.shade900,
                              child: const Text(
                                "All",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                        // Date Selector
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: monthDays[
                                (selectedDate?.toLocal().month as int) - 1],
                            itemBuilder: (context, dayIndex) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                key: ValueKey("$dayIndex"),
                                onTap: () {
                                  selectedDate = DateTime(
                                    (selectedDate?.toLocal().year as int),
                                    (selectedDate?.toLocal().month as int),
                                    (dayIndex + 1),
                                    (selectedDate?.toLocal().hour as int),
                                    (selectedDate?.toLocal().minute as int),
                                    (selectedDate?.toLocal().second as int),
                                  );

                                  _basicStates.put("allTasks", 0);

                                  // This is used to select first day of selected month.
                                  dayUpdater(selectedDate);
                                  selectedTask = tdb.taskSelector(selectedDate);
                                  setState(() {});
                                },
                                child: Container(
                                  // Day View
                                  alignment: Alignment.center,
                                  height: (screenHeight * 8) / 100,
                                  width: widthSelector(dayIndex, screenHeight),
                                  color: colorSelector(dayIndex),
                                  child: Column(
                                    children: [
                                      // Days of current month
                                      Container(
                                        alignment: Alignment.center,
                                        height: (screenHeight * 5) / 100,
                                        child: Text(
                                          "${dayIndex + 1}",
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
                                          weekDays[(((firstDayOfMonth
                                                          ?.toLocal()
                                                          .weekday as int) -
                                                      1) +
                                                  dayIndex) %
                                              7],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerRight,
              height: 50,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side button - Create Task
                  CustomButton(
                    onTap: () {
                      tdb.createNewTask(
                        context: context,
                        titleController: _titleController,
                        taskController: _taskController,
                        onDatePick: () {
                          selectDate(context);
                          // This is used to select first day of selected month.
                          dayUpdater(selectedDate);
                          selectedTask = tdb.taskSelector(selectedDate);
                          setState(() {});
                        },
                        onSave: () {
                          setState(() {
                            _toDoListMem.put(_toDoListMem.length, [
                              false,
                              _titleController.value.text,
                              _taskController.value.text,
                              currentDate,
                              taskUniqueID,
                              _toDoListMem.length,
                            ]);
                          });
                          _titleController.clear();
                          _taskController.clear();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    icon: Icons.add_task,
                  ),
                  CustomButton(
                      onTap: () {
                        tdb.clearTasks(currentDate);
                        setState(() {});
                      },
                      icon: Icons.clear_all),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: selectedTask.length,
                itemBuilder: (context, index) => ToDoCard(
                  key: ValueKey("ToDoCard-$index"),
                  title: selectedTask[index][1],
                  taskToDo: selectedTask[index][2],
                  taskDate: selectedTask[index][3],
                  isChecked: selectedTask[index][0],
                  checkboxOnChanged: (checkTask) {
                    selectedTask[index][0] = !selectedTask[index][0];
                    _toDoListMem.getAt(selectedTask[index][5])[0] =
                        selectedTask[index][0];
                    setState(() {});
                  },
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  onEditButton: () {},
                  onDeleteButton: () {
                    tdb.deleteTask(selectedTask, index);
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
