import 'package:flutter/material.dart';
import 'package:todolist/util/custom_button.dart';
import 'package:todolist/util/todo_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/util/utility_manager.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    Key? key,
    // required this.modeAction,
  }) : super(key: key);

  // final Widget modeAction;
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
  List<List> selectedTask = [];

  // Getting the first day of the month.
  void dayUpdater(DateTime? selectedDateIs) {
    firstDayOfMonth = DateTime(
      (selectedDateIs?.toLocal().year as int),
      (selectedDateIs?.toLocal().month as int),
      1,
    );
  }

  void changeMonthBy(int changeBy) {
    selectedDate = DateTime(
      selectedDate?.toLocal().year as int,
      (selectedDate?.toLocal().month as int) + changeBy,
      (selectedDate?.toLocal().day as int),
      (selectedDate?.toLocal().hour as int),
      (selectedDate?.toLocal().minute as int),
      (selectedDate?.toLocal().second as int),
    );
  }

  @override
  void initState() {
    // selectedTask = tdb.taskSelector(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    UtilManager tdb = UtilManager(
        selectedDate: selectedDate,
        screenHeight: screenHeight,
        screenWidth: screenWidth);
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
            onTap: () async {
              selectedDate = await tdb.selectDate(context);

              // This is used to select first day of selected month.
              dayUpdater(selectedDate);
              selectedTask = tdb.taskSelector(selectedDate);
              setState(() {});
            },
            child: const Icon(Icons.calendar_month),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              _basicStates.put("darkLightMode",
                  _basicStates.get("darkLightMode") == 1 ? 0 : 1);
              // print(_basicStates.get("darkLightMode"));
              _basicStates.get("darkLightMode") == 1 ? ThemeMode.light:ThemeMode.dark;
              setState(() {});
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
          ),
          const SizedBox(width: 10),
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
                            tdb.greetingsUpdater(
                                selectedDate?.toLocal().hour as int),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
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
                    color: _basicStates.get("darkLightMode") == 0
                        ? Colors.green.shade800
                        : Colors.green.shade500,
                    child: Row(
                      children: [
                        // Selects previous month
                        IconButton(
                          disabledColor: tdb.colorSelector(),
                          onPressed: _basicStates.get("allTasks") == 0
                              ? () {
                                  changeMonthBy(-1);

                                  // This is used to select first day of selected month.
                                  dayUpdater(selectedDate);
                                  selectedTask = tdb.taskSelector(selectedDate);
                                  setState(() {});
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),

                        // Shows selected month and year.
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight * 8) / 100,
                            child: Text(
                              _basicStates.get("allTasks") == 0
                                  ? "${monthName[(selectedDate?.month)! - 1]}"
                                      " ${selectedDate?.year}"
                                  : "ALL TASKS",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),

                        // Selects next month.
                        IconButton(
                          disabledColor: tdb.colorSelector(),
                          onPressed: _basicStates.get("allTasks") == 0
                              ? () {
                                  changeMonthBy(1);

                                  // This is used to select first day of selected month.
                                  dayUpdater(selectedDate);
                                  selectedTask = tdb.taskSelector(selectedDate);
                                  setState(() {});
                                }
                              : null,
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
                        // All Task Button
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              _basicStates.put("allTasks", 1);
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              alignment: Alignment.center,
                              width: _basicStates.get("allTasks") == 0
                                  ? (screenHeight * 8) / 100
                                  : (screenHeight * 12) / 100,
                              decoration: BoxDecoration(
                                color: _basicStates.get("allTasks") == 0
                                    ? _basicStates.get("darkLightMode") == 0
                                        ? Colors.green.shade800
                                        : Colors.green.shade500
                                    : _basicStates.get("darkLightMode") == 0
                                        ? Colors.greenAccent
                                        : Colors.green.shade900,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
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
                              child: tdb.dailyTaskSelector(
                                  index: dayIndex,
                                  onTap: () {
                                    selectedDate = DateTime(
                                      (selectedDate?.toLocal().year as int),
                                      (selectedDate?.toLocal().month as int),
                                      (dayIndex + 1),
                                      DateTime.now().toLocal().hour,
                                      DateTime.now().toLocal().minute,
                                      DateTime.now().toLocal().second,
                                    );

                                    _basicStates.put("allTasks", 0);

                                    // This is used to select first day of selected month.
                                    dayUpdater(selectedDate);
                                    selectedTask =
                                        tdb.taskSelector(selectedDate);
                                    setState(() {});
                                  },
                                  weekDay: weekDays[(((firstDayOfMonth
                                                  ?.toLocal()
                                                  .weekday as int) -
                                              1) +
                                          dayIndex) %
                                      7]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerRight,
              height: 60,
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
                        onDatePick: () async {
                          selectedDate = await tdb.selectDate(context);
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
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(5)),
                    buttonText: "Create",
                    icon: Icons.add_task,
                  ),
                  CustomButton(
                      onTap: () {
                        tdb.clearTasks(currentDate);
                        setState(() {});
                      },
                      buttonText: "Clear All",
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(5)),
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
