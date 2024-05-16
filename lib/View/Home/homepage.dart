import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/State/theme_notifier.dart';
import 'package:todolist/View/create_new_task.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';
import 'package:todolist/View/widgets/delete_task_dialog.dart';
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
    List<TaskModel> allTasks = [];

    DateTime selectedDate = ref.watch(dateState);
    AsyncValue<List<TaskModel>> allTaskListener = ref.watch(taskStateGetTasks);

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
                if (index != 0) {
                  dateTimeStateController.selectDay(index);
                } else {
                  dateTimeStateController.selectDay(DateTime.now().day);
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
                  allTaskListener.when(
                    data: (allTasksAre) {
                      if (selectedDate.isAfter(DateTime.now())) {
                        allTasks.addAll(
                          allTasksAre.where(
                            (element) => DateTime.fromMillisecondsSinceEpoch(
                                    element.dueDate)
                                .isAfter(selectedDate),
                          ),
                        );
                      } else {
                        allTasks.addAll(allTasksAre);
                      }
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
                                title: allTasks[index - 1].title,
                                details: allTasks[index - 1].details,
                                creationTime:
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        allTasks[index - 1].creationTime),
                                dueDate: DateTime.fromMicrosecondsSinceEpoch(
                                    allTasks[index - 1].dueDate),
                                pinned: allTasks[index - 1].pinned,
                                isOnline: allTasks[index - 1].isOnline,
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
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
                              ref.read(taskStateDeleteListTask(allTasks));
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
}
