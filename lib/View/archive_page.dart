import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/View%20Model/task_state.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';
import 'package:todolist/View/widgets/delete_task_dialog.dart';
import 'package:todolist/View/widgets/task_tile.dart';

class ArchivePage extends ConsumerWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size scrSize = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    ref.read(taskNotifier.notifier).getTasksArchiveNotifier();

    List<TaskModel> allArchiveTasks = ref.watch(taskNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Archive"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: scrSize.height - statusBarHeight - kToolbarHeight,
          width: scrSize.width,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: allArchiveTasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (allArchiveTasks.isNotEmpty &&
                        !allArchiveTasks[0].isArchived) {
                      return SizedBox(
                        height:
                            scrSize.height - statusBarHeight - kToolbarHeight,
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TaskTile(
                          title: allArchiveTasks[index].title,
                          details: allArchiveTasks[index].details,
                          creationTime: DateTime.fromMicrosecondsSinceEpoch(
                              allArchiveTasks[index].creationTime),
                          dueDate: DateTime.fromMicrosecondsSinceEpoch(
                              allArchiveTasks[index].dueDate),
                          pinned: allArchiveTasks[index].pinned,
                          isOnline: allArchiveTasks[index].isOnline,
                          isArchive: allArchiveTasks[index].isArchived,
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DeleteTaskDialog(
                                  title: "Delete task from archive?",
                                  buttonTitle: "Delete",
                                  subTitle:
                                      "This task will be removed forever!",
                                  buttonColor: Colors.red.shade900,
                                  onPress: () {
                                    ref
                                        .read(taskNotifier.notifier)
                                        .deleteTaskArchiveNotifier(
                                            allArchiveTasks[index]);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                          onMarkDone: () {},
                        ),
                      );
                    }
                  },
                ),
              ),
              CustomTextButton(
                width: scrSize.width - 40,
                height: 50,
                color: Colors.transparent,
                borderColor: Theme.of(context).highlightColor,
                textColor: Theme.of(context).highlightColor,
                borderWidth: 2,
                text: "Clear Archive",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteTaskDialog(
                        title: "Clear Archive?",
                        buttonTitle: "Delete All",
                        subTitle: "All of the archives will be deleted!",
                        buttonColor: Colors.red.shade900,
                        onPress: () {
                          ref
                              .read(taskNotifier.notifier)
                              .deleteListTaskArchiveNotifier(allArchiveTasks);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
