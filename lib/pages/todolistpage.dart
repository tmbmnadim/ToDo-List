import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todolist/data/listsvalue.dart';
import 'package:todolist/pages/todocard.dart';

class ListPage extends StatefulWidget {
  ListPage({
    Key? key,
    required this.modeAction,
  }) : super(key: key);

  final Widget modeAction;
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
  bool isCheckedbox = false;

  List<List> selectedTask = [];

  List<List> taskSelector(DateTime? selectedDateTask) {
    List<List> selectedTask = [];
    for (int i = 0; i < toDoList.length; i++) {
      if (toDoList[i].contains(
          "${selectedDateTask?.day}/${selectedDateTask?.month}/${selectedDateTask?.year}")) {
        selectedTask.add(toDoList[i]);
      }
    }
    return selectedTask;
  }

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
        selectedDate = selectedDate = DateTime(
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

  void dayUpdater(DateTime? selectedDateIs) {
    firstDayOfMonth = DateTime(
      (selectedDateIs?.toLocal().year as int),
      (selectedDateIs?.toLocal().month as int),
      1,
    );
  }

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
    selectedTask = taskSelector(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    selectedTask = taskSelector(selectedDate);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            // Calender Icon Appbar
            onTap: () {
              selectDate(context);

              // This is used to select first day of selected month.
              dayUpdater(selectedDate);
              selectedTask = taskSelector(selectedDate);
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
      body: Container(
        color: Color.fromRGBO(100, 0, 0, 0.1), // Total background color.
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
                    color: Colors.blue,
                    child: Row(
                      children: [
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
                            selectedTask = taskSelector(selectedDate);
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
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
                            selectedTask = taskSelector(selectedDate);
                            setState(() {});
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: (screenHeight * 11) / 100,
                    width: screenWidth,
                    color: const Color.fromRGBO(125, 125, 125, 0.25),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          monthDays[(selectedDate?.toLocal().month as int) - 1],
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

                            // This is used to select first day of selected month.
                            dayUpdater(selectedDate);
                            selectedTask = taskSelector(selectedDate);
                            setState(() {});
                          },
                          child: Container(
                            // Day View
                            alignment: Alignment.center,
                            height: (screenHeight * 8) / 100,
                            width: selectedDate?.toLocal().day == dayIndex + 1
                                ? (screenHeight * 12) / 100
                                : (screenHeight * 8) / 100,
                            color: selectedDate?.toLocal().day == dayIndex + 1
                                ? Color.fromARGB(255, 0, 88, 252)
                                : Colors.blue,
                            child: Column(
                              children: [
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      height: 50,
                      width: 80,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(20, 23),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 10,
                            spreadRadius: -18,
                          ),
                          BoxShadow(
                            offset: Offset(5, 5),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 10,
                            spreadRadius: -5,
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 27, 63, 28),
                          Color.fromARGB(255, 37, 83, 38),
                          Color.fromARGB(255, 61, 141, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 26, 59, 27),
                        ]),
                      ),
                      child: const Icon(
                        Icons.add_task,
                        size: 35,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 23),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 10,
                            spreadRadius: -18,
                          ),
                          BoxShadow(
                            offset: Offset(0, 5),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 5,
                            spreadRadius: -5,
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 27, 63, 28),
                          Color.fromARGB(255, 27, 63, 28),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 61, 141, 64),
                          Color.fromARGB(255, 27, 63, 28),
                          Color.fromARGB(255, 27, 63, 28),
                        ]),
                      ),
                      child: const Icon(
                        Icons.add_task,
                        size: 35,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      height: 50,
                      width: 80,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-10, 23),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 10,
                            spreadRadius: -18,
                          ),
                          BoxShadow(
                            offset: Offset(-5, 5),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 10,
                            spreadRadius: -5,
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 26, 59, 27),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 62, 150, 64),
                          Color.fromARGB(255, 61, 141, 64),
                          Color.fromARGB(255, 37, 83, 38),
                          Color.fromARGB(255, 27, 63, 28),
                        ]),
                      ),
                      child: const Icon(
                        Icons.add_task,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: selectedTask.length,
                itemBuilder: (context, index) => ToDoCard(
                    key: ValueKey("ToDoCard-$index"),
                    title: selectedTask[index][1],
                    taskDate: selectedTask[index][2],
                    isCheckedbox: selectedTask[index][0],
                    checkboxOnChanged: (checkTask) {
                      selectedTask[index][0] = !selectedTask[index][0];
                      setState(() {});
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
