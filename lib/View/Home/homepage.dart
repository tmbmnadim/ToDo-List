import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Riverpod/theme_notifier.dart';
import 'package:todolist/View/archive_page.dart';
import 'package:todolist/View/create_new_task.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';
import 'package:todolist/View/widgets/delete_task_dialog.dart';
import 'package:todolist/View/widgets/show_lottie.dart';
import 'package:todolist/View/widgets/welcom_static_bg.dart';
import '../../Riverpod/date_state.dart';
import '../../Riverpod/task_state.dart';
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
    double statusBarHeight = MediaQuery.of(context).padding.top;

    ref.read(taskNotifier.notifier).getTasksLocalNotifier();

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ArchivePage()));
            },
            icon: const Icon(Icons.archive),
          ),
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
          ),
        ],
        toolbarHeight: kToolbarHeight,
        centerTitle: true,
      ),
      body: SizedBox(
        height: scrSize.height - statusBarHeight - kToolbarHeight,
        width: scrSize.width,
        child: Column(
          children: [
            WelcomeBGStatic(
              height: 200,
              width: scrSize.width,
            ),
            // const ShowLottie(),
            MonthViewer(
              height: 60,
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
              height: 60,
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
                  if (allTasksAre.isNotEmpty && !allTasksAre[0].isArchived)
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
                              isArchive: allTasksAre[index - 1].isArchived,
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteTaskDialog(
                                      title: "Delete Task?",
                                      buttonTitle: "Delete",
                                      subTitle: "This task will be removed!",
                                      buttonColor: Colors.red.shade900,
                                      onPress: () {
                                        ref
                                            .read(taskNotifier.notifier)
                                            .deleteTaskLocalNotifier(
                                                allTasksAre[index - 1]);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                              onMarkDone: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteTaskDialog(
                                      title: "Mark Complete?",
                                      buttonTitle: "Mark Complete",
                                      subTitle:
                                          "The task will be moved to archive!",
                                      onPress: () {
                                        ref
                                            .read(taskNotifier.notifier)
                                            .moveToArchiveNotifier(
                                                allTasksAre[index - 1]);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  if (allTasksAre.isNotEmpty && allTasksAre[0].isArchived)
                    const Center(
                      child: CircularProgressIndicator(),
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
                            title: "Delete All Tasks?",
                            buttonTitle: "Delete",
                            subTitle: "This will DELETE all of the tasks!",
                            buttonColor: Colors.red.shade900,
                            onPress: () {
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
