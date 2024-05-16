import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Services/task_services.dart';

final FutureProvider<List<TaskModel>> taskStateGetTasks =
    FutureProvider<List<TaskModel>>(
        (ref) async => await TaskServices().getTasksLocal());

taskStateCreateTask(TaskModel task) =>
    FutureProvider((ref) => TaskServices().createTaskLocal(task));

taskStateDeleteTask(TaskModel task) =>
    FutureProvider((ref) => TaskServices().deleteTaskLocal(task));

taskStateDeleteListTask(List<TaskModel> tasks) =>
    FutureProvider((ref) => TaskServices().deleteListTaskLocal(tasks));
