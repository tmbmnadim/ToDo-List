import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/State/theme_notifier.dart';

import 'Models/task_model.dart';
import 'View/Home/homepage.dart';
import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  runApp(const ProviderScope(child: ToDoList()));
}

class ToDoList extends ConsumerStatefulWidget {
  // final ThemeMode? themeMode;
  const ToDoList({super.key});

  @override
  ConsumerState<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends ConsumerState<ToDoList> {
  bool isFirstTime = true;
  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      ref.read(themeNotifier.notifier).getTheme();
      isFirstTime = false;
    }
    ThemeMode themeMode = ref.watch(themeNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo List",
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: lightModePrimary,
        primaryColorDark: lightModePrimaryDark,
        primaryColorLight: lightModePrimaryLight,
        canvasColor: darkModePrimaryLight,
        scaffoldBackgroundColor: Colors.white,
        textTheme: todoTextTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: darkModePrimary,
        primaryColorDark: darkModePrimaryDark,
        primaryColorLight: darkModePrimaryLight,
        canvasColor: lightModePrimaryDark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32),
        textTheme: todoTextTheme,
      ),
      builder: EasyLoading.init(),
      home: const Homepage(),
    );
  }
}
