import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/Riverpod/task_state.dart';
import 'package:todolist/Riverpod/theme_notifier.dart';
import 'package:todolist/View%20Models/notification_view_model.dart';
import 'Models/task_model.dart';
import 'View/Home/homepage.dart';
import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  tz.initializeTimeZones();

  runApp(const ProviderScope(child: ToDoList()));
}

class ToDoList extends ConsumerStatefulWidget {
  const ToDoList({super.key});

  @override
  ConsumerState<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends ConsumerState<ToDoList> {
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    ref.read(themeNotifier.notifier).getTheme();
    ref.read(taskNotifier.notifier).getAllTasks();
    ref.read(taskNotifier.notifier).expiredTasksToArchive();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotificationViewModel(context).initNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ref.watch(themeNotifier);
    FlutterNativeSplash.remove();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo List",
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: appBarTheme,
        primaryColor: lightModePrimary,
        primaryColorDark: lightModePrimaryDark,
        primaryColorLight: lightModePrimaryLight,
        canvasColor: darkModePrimaryLight,
        highlightColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        textTheme: todoTextTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: darkModePrimary,
        primaryColorDark: darkModePrimaryDark,
        primaryColorLight: darkModePrimaryLight,
        canvasColor: lightModePrimaryDark,
        highlightColor: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32),
        textTheme: todoTextTheme,
      ),
      builder: EasyLoading.init(),
      home: const Homepage(),
    );
  }
}
