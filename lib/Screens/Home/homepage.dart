import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todolist/widgets/animated_welcome_bar.dart';
import 'package:todolist/app_theme.dart';
import 'package:todolist/widgets/create_delete_task_buttons.dart';
import 'package:todolist/widgets/custom_icon_button.dart';
import 'package:todolist/widgets/custom_methods.dart';
import 'package:todolist/widgets/date_list.dart';
import 'package:todolist/widgets/month_viewer.dart';
import 'package:todolist/widgets/task_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
    // required this.modeAction,
  }) : super(key: key);

  // final Widget modeAction;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isDay = false;
  @override
  Widget build(BuildContext context) {
    primaryColorDefiner(isDay);
    Size scrSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDay ? Colors.white : Colors.black87,
      appBar: AppBar(
        title: const Text("ToDo List"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDay = !isDay;
              });
            },
            icon: Icon(
              isDay ? Icons.sunny : Icons.nightlight_rounded,
            ),
          )
        ],
        toolbarHeight: kToolbarHeight,
        centerTitle: true,
      ),
      body: SizedBox(
        height: scrSize.height - kToolbarHeight + 10,
        width: scrSize.width,
        child: Column(
          children: [
            Container(
              height: 180,
              width: scrSize.width,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: isDay ? primaryColorDark : secondaryColorDay,
                    width: 8,
                  ),
                  vertical: BorderSide(
                    color: isDay ? primaryColorDark : secondaryColorDay,
                    width: 4,
                  ),
                ),
              ),
              child: AnimatedWelcomeBar(
                height: 180,
                dayStatus: isDay ? "Good Morning" : "Good Night",
              ),
            ),
            MonthViewer(
              height: 80,
              monthText: "Month Name",
              color: primaryColor,
              width: scrSize.width,
              onLeft: () {},
              onRight: () {},
            ),
            DateListButtons(
              height: 80,
              width: scrSize.width,
              color: primaryColor,
              borderColor: isDay ? primaryColorDark : secondaryColorDay,
              daysInMonth: getDaysInMonth(DateTime.now()),
              onTap: (index) {},
            ),
            Divider(
              color: primaryColor,
              height: 2,
              thickness: 2,
            ),
            Expanded(
              child: Stack(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 100 + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox(height: 60);
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TaskTile(
                              title: "Task Title",
                              details: "Task Details",
                              creationTime: DateTime.now(),
                              dueDate: DateTime.now(),
                              pinned: false,
                              isOnline: true,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  CreateDeleteTaskButtons(
                    height: 50,
                    color: primaryColor,
                    width: scrSize.width,
                    onCreate: () {},
                    onDelete: () {},
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
