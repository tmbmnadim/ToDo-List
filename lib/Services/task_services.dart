import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:todolist/Models/task_model.dart';

class TaskServices {
  TaskServices();

  Future<List<TaskModel>> getTasksLocal() async {
    List<TaskModel> tasks = [];

    Box taskBox = await Hive.openBox<TaskModel>("tasks");

    Map<dynamic, dynamic> tasksMap = taskBox.toMap();
    if (tasksMap.isNotEmpty) {
      tasks.addAll((tasksMap.values as Iterable<TaskModel>));
    }

    return tasks;
  }

  Future<void> createTaskLocal(TaskModel task) async {
    EasyLoading.show(status: "Creating Tasks...");
    Box taskBox = await Hive.openBox<TaskModel>("tasks");

    await taskBox.put(task.creationTime.toString(), task).then((value) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        EasyLoading.dismiss();
      });
    });
  }

  Future<void> deleteTaskLocal(TaskModel task) async {
    Box taskBox = await Hive.openBox<TaskModel>("tasks");

    await taskBox.delete(task.creationTime.toString());
  }

  Future<void> deleteListTaskLocal(List<TaskModel> tasks) async {
    Box taskBox = await Hive.openBox<TaskModel>("tasks");
    List<String> taskKeys = [];
    for (var singleTask in tasks) {
      taskKeys.add(singleTask.creationTime.toString());
    }

    await taskBox.deleteAll(taskKeys);
  }

  Future<List<TaskModel>> getTasksArchive() async {
    List<TaskModel> tasks = [];

    Box taskArchiveBox = await Hive.openBox<TaskModel>("tasksArchive");

    Map<dynamic, dynamic> tasksArchiveMap = taskArchiveBox.toMap();
    if (tasksArchiveMap.isNotEmpty) {
      tasks.addAll((tasksArchiveMap.values as Iterable<TaskModel>));
    }

    return tasks;
  }

  Future<void> moveToArchive(TaskModel task) async {
    EasyLoading.show(status: "Moving to archive...");
    task = task.copyWith(isArchived: true);
    deleteTaskLocal(task);
    Box taskArchiveBox = await Hive.openBox<TaskModel>("tasksArchive");

    await taskArchiveBox.put(task.creationTime.toString(), task).then((value) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        EasyLoading.dismiss();
      });
    });
  }

  Future<void> deleteTaskArchive(TaskModel task) async {
    Box taskArchiveBox = await Hive.openBox<TaskModel>("tasksArchive");

    await taskArchiveBox.delete(task.creationTime.toString());
  }

  Future<void> deleteListTaskArchive(List<TaskModel> tasks) async {
    Box taskArchiveBox = await Hive.openBox<TaskModel>("tasksArchive");
    List<String> taskKeys = [];
    for (var singleTask in tasks) {
      taskKeys.add(singleTask.creationTime.toString());
    }

    await taskArchiveBox.deleteAll(taskKeys);
  }
}
