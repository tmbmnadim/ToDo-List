import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Services/task_services.dart';

NotifierProvider<TaskNotifier, List<TaskModel>> taskNotifier =
    NotifierProvider<TaskNotifier, List<TaskModel>>(() => TaskNotifier());

class TaskNotifier extends Notifier<List<TaskModel>> {
  @override
  List<TaskModel> build() {
    return [];
  }

  Future<void> getAllTasks() async {
    state = await TaskServices().getTasksLocal();
  }

  void expiredTasksToArchive() async {
    await getAllTasks().whenComplete(() async {
      if (state.isNotEmpty) {
        List<TaskModel> expiredTasks = [];
        for (TaskModel task in state) {
          DateTime dueDate = DateTime.fromMillisecondsSinceEpoch(task.dueDate);
          if (DateTime.now().isAfter(dueDate)) {
            expiredTasks.add(task);
          }
        }
        for (var singleTask in expiredTasks) {
          await TaskServices().moveToArchive(singleTask, noNotification: true);
        }
        print(
            "======================${expiredTasks.length}======================");
      }
    });
  }

  void getTasksOfDateLocalNotifier(DateTime date) async {
    state = await TaskServices().getTasksLocal();

    List<TaskModel> selectedTasks = state.where((element) {
      DateTime dueDate = DateTime.fromMillisecondsSinceEpoch(element.dueDate);
      return dueDate.difference(date) < const Duration(hours: 24) &&
          dueDate.difference(date) > const Duration(hours: 0);
    }).toList();
    state = selectedTasks;
  }

  void createTaskLocalNotifier(TaskModel task) async {
    await TaskServices().createTaskLocal(task);
    getAllTasks();
  }

  void deleteTaskLocalNotifier(TaskModel task) async {
    await TaskServices().deleteTaskLocal(task);
    getAllTasks();
  }

  void deleteListTaskLocalNotifier(List<TaskModel> tasks) async {
    await TaskServices().deleteListTaskLocal(tasks);
    getAllTasks();
  }

  void getTasksArchiveNotifier() async {
    state = await TaskServices().getTasksArchive();
  }

  void moveToArchiveNotifier(TaskModel task) async {
    await TaskServices().moveToArchive(task);
    getAllTasks();
  }

  void deleteTaskArchiveNotifier(TaskModel task) async {
    await TaskServices().deleteTaskArchive(task);
    getTasksArchiveNotifier();
  }

  void deleteListTaskArchiveNotifier(List<TaskModel> tasks) async {
    await TaskServices().deleteListTaskArchive(tasks);
    getTasksArchiveNotifier();
  }
}
