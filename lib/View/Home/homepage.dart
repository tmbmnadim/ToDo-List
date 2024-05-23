import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/View%20Model/theme_notifier.dart';
import 'package:todolist/View/create_new_task.dart';
import 'package:todolist/View/widgets/delete_task_dialog.dart';
import '../../View Model/date_state.dart';
import '../../View Model/task_state.dart';
import '../widgets/animated_welcome_bar.dart';
import '../widgets/create_delete_task_buttons.dart';
import '../widgets/custom_methods.dart';
import '../widgets/date_list.dart';
import '../widgets/month_viewer.dart';
import '../widgets/task_tile.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size scrSize = MediaQuery.of(context).size;

    List<TaskModel> allTasksAre = ref.watch(taskNotifier);

    DateTimeState dateTimeStateController = ref.read(dateState.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("ToDo List"),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(themeNotifier.notifier)
                  .changeTheme(Theme.of(context).brightness);
              ThemeMode themeMode =
                  Theme.of(context).brightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
              ref.read(themeNotifier.notifier).setTheme(themeMode);
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.sunny
                  : Icons.nightlight_rounded,
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
                border: Border.all(
                  color: Theme.of(context).canvasColor,
                  width: 8,
                ),
              ),
              child: const AnimatedWelcomeBar(
                height: 180,
                dayStatus: "Good Morning",
              ),
            ),
            MonthViewer(
              height: 80,
              monthText: DateFormat("LLLL").format(ref.watch(dateState)),
              color: Theme.of(context).primaryColor,
              width: scrSize.width,
              onLeft: () {
                dateTimeStateController.previousMonth();
              },
              onRight: () {
                dateTimeStateController.nextMonth();
              },
            ),
            DateListButtons(
              height: 80,
              width: scrSize.width,
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColorLight,
              daysInMonth: getDaysInMonth(ref.watch(dateState)),
              onTap: (index) {
                if (index != 0) {
                  dateTimeStateController.selectDay(index);
                  ref
                      .read(taskNotifier.notifier)
                      .getTasksOfDateLocalNotifier(ref.watch(dateState));
                } else {
                  dateTimeStateController.selectDay(DateTime.now().day);
                  ref.read(taskNotifier.notifier).getTasksLocalNotifier();
                }
              },
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 2,
              thickness: 2,
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: allTasksAre.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox(height: 60);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TaskTile(
                            title: allTasksAre[index - 1].title,
                            details: allTasksAre[index - 1].details,
                            creationTime: DateTime.fromMicrosecondsSinceEpoch(
                                allTasksAre[index - 1].creationTime),
                            dueDate: DateTime.fromMicrosecondsSinceEpoch(
                                allTasksAre[index - 1].dueDate),
                            pinned: allTasksAre[index - 1].pinned,
                            isOnline: allTasksAre[index - 1].isOnline,
                          ),
                        );
                      }
                    },
                  ),
                  CreateDeleteTaskButtons(
                    height: 50,
                    color: Theme.of(context).primaryColor,
                    width: scrSize.width,
                    onCreate: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CreateNewTask(),
                      );
                    },
                    onDelete: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteTaskDialog(
                            onDelete: () {
                              ref
                                  .read(taskNotifier.notifier)
                                  .deleteListTaskLocalNotifier(allTasksAre);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TaskModel> taskOfDate(
      DateTime selectedDate, List<TaskModel> allTasksAre) {
    if (selectedDate.isAfter(DateTime.now())) {
      return allTasksAre
          .where(
            (element) => DateTime.fromMillisecondsSinceEpoch(element.dueDate)
                .isAfter(selectedDate),
          )
          .toList();
    } else {
      return allTasksAre;
    }
  }
}
