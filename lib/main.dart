import 'package:flutter/material.dart';
import 'package:todolist/pages/todo-list-page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  var _toDoListMem = await Hive.openBox('taskBox');
  var _basicStates = await Hive.openBox('stateBox');
  _basicStates.put("darkLightMode", 0);

  runApp(const MyHome());
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _basicStates = Hive.box('stateBox');
  ThemeMode darkLightMode = ThemeMode.light;
  IconData modeIcon = Icons.dark_mode;
  @override
  Widget build(BuildContext context) {
    darkLightMode = _basicStates.get("darkLightMode") == 0
        ? ThemeMode.light
        : ThemeMode.dark;
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
      themeMode: darkLightMode,
      home: ListPage(
        modeAction: GestureDetector(
          onTap: () {
            darkLightMode == ThemeMode.light
                ? darkLightMode = ThemeMode.dark
                : darkLightMode = ThemeMode.light;
            _basicStates.put(
                "darkLightMode", darkLightMode == ThemeMode.light ? 0 : 1);
            setState(() {});
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: modeIcon == Icons.light_mode
                  ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                  : Tween<double>(begin: 0.75, end: 1).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: darkLightMode == ThemeMode.light
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
