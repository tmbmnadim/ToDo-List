import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Services/task_services.dart';

final FutureProvider<List<TaskModel>> taskStateGetTasks =
    FutureProvider<List<TaskModel>>(
        (ref) async => TaskServices().getTasksLocal());

taskStateSaveTask(TaskModel task) =>
    FutureProvider((ref) => TaskServices().saveTaskLocal(task));

taskStateDeleteTask(TaskModel task) =>
    FutureProvider((ref) => TaskServices().deleteTaskLocal(task));
