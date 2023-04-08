import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/pages/sign_up_page.dart';
import 'package:todolist/pages/todo_list_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var _toDoListMem = await Hive.openBox('taskBox');
  var basicStates = await Hive.openBox('stateBox');
  basicStates.put("darkLightMode", ThemeMode.system==ThemeMode.light?1:0);
  basicStates.put("allTasks", 0);

  runApp(const MyHome());
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
      home: SignUpPage(
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

      // ListPage(
      //   modeAction: GestureDetector(
      //     onTap: () {
      //       _basicStates.put(
      //           "darkLightMode", _basicStates.get("darkLightMode") == 1 ? 0 : 1);
      //       setState(() {});
      //     },
      //     child: AnimatedSwitcher(
      //       duration: const Duration(milliseconds: 300),
      //       transitionBuilder: (child, anim) => RotationTransition(
      //         turns: _basicStates.get("darkLightMode") == 0
      //             ? Tween<double>(begin: 1, end: 0.75).animate(anim)
      //             : Tween<double>(begin: 0.75, end: 1).animate(anim),
      //         child: FadeTransition(opacity: anim, child: child),
      //       ),
      //       child: _basicStates.get("darkLightMode") == 0
      //           ? const Icon(
      //               Icons.light_mode,
      //               key: ValueKey("lightMode"),
      //             )
      //           : const Icon(
      //               Icons.dark_mode,
      //               key: ValueKey("darkMode"),
      //             ),
      //     ),
      //   ),
      // ),
    );
  }
}
