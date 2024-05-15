import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/State/theme_notifier.dart';
import 'package:todolist/app_theme.dart';
import '../../State/date_state.dart';
import '../../State/task_state.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: Consumer(
        builder: (context, ref, child) {
          AsyncValue<List<TaskModel>> allTaskListener =
              ref.watch(taskStateGetTasks);
          DateTime selectedDate = ref.watch(dateState);
          DateTimeState dateTimeStateController = ref.watch(dateState.notifier);
          return SizedBox(
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
                  monthText: DateFormat("LLLL").format(selectedDate),
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
                  daysInMonth: getDaysInMonth(selectedDate),
                  onTap: (index) {
                    dateTimeStateController.selectDay(index + 1);
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
                      allTaskListener.when(
                        data: (allTasks) {
                          return ListView.builder(
                            itemCount: allTasks.length + 1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return const SizedBox(height: 60);
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TaskTile(
                                    title: allTasks[index].title,
                                    details: allTasks[index].details,
                                    creationTime:
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            allTasks[index].creationTime),
                                    dueDate:
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            allTasks[index].dueDate),
                                    pinned: allTasks[index].pinned,
                                    isOnline: allTasks[index].isOnline,
                                  ),
                                );
                              }
                            },
                          );
                        },
                        error: (error, s) {
                          return Center(
                            child: Text(
                              error.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        },
                        loading: () {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor),
                          );
                        },
                      ),
                      CreateDeleteTaskButtons(
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        width: scrSize.width,
                        onCreate: () {},
                        onDelete: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
