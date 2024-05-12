import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Sources/task_source.dart';
import 'package:todolist/State/task_state.dart';
import 'package:todolist/State/task_state_model.dart';
import 'package:todolist/app_theme.dart';
import '../widgets/animated_welcome_bar.dart';
import '../widgets/create_delete_task_buttons.dart';
import '../widgets/custom_methods.dart';
import '../widgets/date_list.dart';
import '../widgets/month_viewer.dart';
import '../widgets/task_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isDay = false;
  TaskModel task = TaskModel(
    title: "title",
    details: "details",
    creationTime: DateTime.now().millisecondsSinceEpoch,
    dueDate: DateTime(2024, 5, 15, 13, 30).millisecondsSinceEpoch,
    pinned: false,
    isOnline: true,
  );
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
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                TaskStateModel dataGetter = ref.watch(taskState);
                return MonthViewer(
                  height: 80,
                  monthText: "Month Name ${dataGetter.testVar}",
                  color: primaryColor,
                  width: scrSize.width,
                  onLeft: () async {
                    TaskSourceLocal().saveTaskLocal(task);
                  },
                  onRight: () async {
                    print(await TaskSourceLocal().getTasksLocal(0));
                  },
                );
              },
            ),
            DateListButtons(
              height: 80,
              width: scrSize.width,
              color: primaryColor,
              borderColor: isDay ? primaryColorDark : secondaryColorDay,
              daysInMonth: getDaysInMonth(DateTime.now()),
              onTap: (index) async {
                await TaskSourceLocal().deleteTaskLocal(task);
              },
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
