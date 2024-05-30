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

  void getTasksLocalNotifier() async {
    state = await TaskServices().getTasksLocal();
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
    getTasksLocalNotifier();
  }

  void deleteTaskLocalNotifier(TaskModel task) async {
    await TaskServices().deleteTaskLocal(task);
    getTasksLocalNotifier();
  }

  void deleteListTaskLocalNotifier(List<TaskModel> tasks) async {
    await TaskServices().deleteListTaskLocal(tasks);
    getTasksLocalNotifier();
  }

  void getTasksArchiveNotifier() async {
    state = await TaskServices().getTasksArchive();
  }

  void moveToArchiveNotifier(TaskModel task) async {
    await TaskServices().moveToArchive(task);
    getTasksLocalNotifier();
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
