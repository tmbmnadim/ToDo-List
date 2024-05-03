// import 'package:hive/hive.dart';
// import 'package:todolist/Models/task_model.dart';
//
// class LocalRepo {
//   Future getTasksRepo() async {
//     return await Hive.openBox('taskBox');
//   }
//
//   Future getStateRepo() async {
//     return await Hive.openBox('stateBox');
//   }
//
//   void saveTasksRepo({required TaskModel taskModel}) async {
//     final Box taskBox = await Hive.openBox('taskBox');
//
//     taskBox.put(
//       taskModel.creationTime,
//       taskModel,
//     );
//   }
//
//   void saveStateRepo({
//     required String key,
//     required dynamic value,
//   }) async {
//     final Box stateBox = await Hive.openBox('stateBox');
//     stateBox.put(
//       key,
//       value,
//     );
//   }
// }
