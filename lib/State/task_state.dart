import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/State/task_state_model.dart';

final taskState =
    ChangeNotifierProvider<TaskStateModel>((ref) => TaskStateModel());
