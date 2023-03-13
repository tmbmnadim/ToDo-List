import 'package:flutter/material.dart';

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
  List<int> selectedDay = [
    (DateTime.now().toLocal().year),
    (DateTime.now().toLocal().month),
    (DateTime.now().toLocal().day)
  ];

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
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            // Calender Icon Appbar
            onTap: () {
              selectDate(context);
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
                          child: const Text(
                            "Greetings!",
                            style: TextStyle(
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
                                selectedDate?.toLocal().day as int);
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
                            );
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
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          key: ValueKey("$index"),
                          onTap: () {
                            selectedDay = [
                              (selectedDate?.toLocal().year as int),
                              (selectedDate?.toLocal().month as int),
                              (index + 1)
                            ];
                            setState(() {});
                          },
                          child: Container(
                            // Day View
                            alignment: Alignment.center,
                            height: (screenHeight * 8) / 100,
                            width: (screenHeight * 8) / 100,
                            color: Colors.blue,
                            child: Column(
                              children: [
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
                                Container(
                                  alignment: Alignment.center,
                                  height: (screenHeight * 3) / 100,
                                  child: Text(
                                    weekDays[(((selectedDate?.toLocal().weekday
                                                    as int) -
                                                1) +
                                            index) %
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
            Expanded(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 150,
                    width: 20,
                    color: Colors.green,
                  ),
                  Text(
                    "Date: ${selectedDay[2]}/${selectedDay[1]}/${selectedDay[0]}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 45,
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
