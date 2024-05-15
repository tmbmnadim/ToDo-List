import 'package:hive/hive.dart';
import 'package:todolist/Models/task_model.dart';

class TaskServices {
  TaskServices();

  Future<List<TaskModel>> getTasksLocal() async {
    List<TaskModel> tasks = [];

    Box taskBox = await Hive.openBox<TaskModel>("tasks");

    Map<dynamic, dynamic> tasksMap = taskBox.toMap();
    if (tasksMap.isNotEmpty) {
      for (int i = 0; i < tasksMap.length; i++) {
        tasks.add(tasksMap[0]);
      }
    }

    return tasks;
  }

  Future<void> saveTaskLocal(TaskModel task) async {
    Box taskBox = await Hive.openBox<TaskModel>("tasks");

    await taskBox.put(task.creationTime.toString(), task);
  }

  Future<void> deleteTaskLocal(TaskModel task) async {
    Box taskBox = await Hive.openBox<TaskModel>("tasks");

    await taskBox.delete(task.creationTime.toString());
  }
}
