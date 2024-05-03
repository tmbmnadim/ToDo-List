import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/Screens/Home/homepage.dart';
import 'Screens/Authentication/sign_up_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  await Hive.openBox('taskBox');
  var basicStates = await Hive.openBox('stateBox');
  basicStates.put("darkLightMode", ThemeMode.system == ThemeMode.light ? 1 : 0);
  basicStates.put("allTasks", 0);

  runApp(const ToDoList());
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final _basicStates = Hive.box('stateBox');
  IconData modeIcon = Icons.dark_mode;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo List",
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.green.shade500),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        brightness: Brightness.light,
        primaryColor: Colors.lightGreen,
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.green.shade800),
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
      themeMode: _basicStates.get("darkLightMode") == 1
          ? ThemeMode.light
          : ThemeMode.dark,
      builder: EasyLoading.init(),
      home: Homepage(
        modeAction: GestureDetector(
          onTap: () {
            _basicStates.put("darkLightMode",
                _basicStates.get("darkLightMode") == 1 ? 0 : 1);
            setState(() {});
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: _basicStates.get("darkLightMode") == 0
                  ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                  : Tween<double>(begin: 0.75, end: 1).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: _basicStates.get("darkLightMode") == 1
                ? const Icon(
                    Icons.light_mode,
                    key: ValueKey("lightMode"),
                  )
                : const Icon(
                    Icons.dark_mode,
                    key: ValueKey("darkMode"),
                  ),
          ),
        ),
      ),
    );
  }
}
