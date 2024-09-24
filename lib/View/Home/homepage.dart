import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Riverpod/theme_notifier.dart';
import 'package:todolist/View/archive_page.dart';
import 'package:todolist/View/create_new_task.dart';
import 'package:todolist/View/widgets/delete_task_dialog.dart';
import 'package:todolist/View/widgets/welcom_static_bg.dart';
import '../../Riverpod/date_state.dart';
import '../../Riverpod/task_state.dart';
import '../widgets/create_delete_task_buttons.dart';
import '../widgets/custom_methods.dart';
import '../widgets/date_list.dart';
import '../widgets/month_viewer.dart';
import '../widgets/task_tile.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage>
    with SingleTickerProviderStateMixin {
  FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
  DateTimeState dateTimeStateController = DateTimeState();
  List<TaskModel> allTasksAre = [];
  late AnimationController _aniCtrl;
  late Animation<int> _ani;
  List<String> titleTexts = [
    "Older Tasks are moved to archive",
    "Older Tasks are moved to arc",
    "Older Tasks are moved to",
    "Older Tasks are moved",
    "Older Tasks are mo",
    "Older Tasks are",
    "Older Tasks",
    "Older Ta",
    "Older",
    "Ol",
    "",
    "To",
    "ToDo",
    "ToDo Li",
    "ToDo List",
  ];

  @override
  void initState() {
    super.initState();
    _aniCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _ani = _aniCtrl.drive(
      TweenSequence<int>(
        [
          TweenSequenceItem<int>(
            tween: IntTween(
              begin: 0,
              end: 10,
            ).chain(
              CurveTween(
                curve: const Interval(0, 0.8),
              ),
            ),
            weight: 50,
          ),
          TweenSequenceItem<int>(
            tween: IntTween(
              begin: 10,
              end: titleTexts.length - 1,
            ).chain(
              CurveTween(
                curve: const Interval(0.8, 1),
              ),
            ),
            weight: 50,
          ),
        ],
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      allTasksAre = ref.watch(taskNotifier);
      dateTimeStateController = ref.read(dateState.notifier);
      Future.delayed(const Duration(seconds: 2))
          .whenComplete(() => _aniCtrl.forward());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _aniCtrl,
          builder: (context, child) => Text(
            titleTexts[_ani.value],
            style: _ani.value <= 11
                ? Theme.of(context).textTheme.titleSmall
                : Theme.of(context).textTheme.titleMedium,
          ),
        ),
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
                  ref.read(taskNotifier.notifier).getAllTasks();
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
                              creationTime: DateTime.fromMillisecondsSinceEpoch(
                                  allTasksAre[index - 1].creationTime),
                              dueDate: DateTime.fromMillisecondsSinceEpoch(
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
                                        flp.cancel(allTasksAre[index - 1].id);
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
                        builder: (context) => CreateNewTask(
                          id: allTasksAre.isEmpty
                              ? 0
                              : allTasksAre.first.id + 1,
                        ),
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
                              flp.cancelAll();
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
