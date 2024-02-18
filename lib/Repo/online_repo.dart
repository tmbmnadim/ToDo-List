import 'package:hive/hive.dart';
import 'package:todolist/Models/task_model.dart';

class OnlineRepo {
  Future getTasksRepo() async {
    return await Hive.openBox('taskBox');
  }

  Future getStateRepo() async {
    return await Hive.openBox('stateBox');
  }

  void saveTasksRepo({
    required TaskModel taskModel
  }) async {
    final Box toDoListMem = await Hive.openBox('taskBox');
    List<TaskModel> tasks = toDoListMem.get('tasks');

    toDoListMem.put(
      taskModel.creationTime,
      taskModel,
    );
  }
}
