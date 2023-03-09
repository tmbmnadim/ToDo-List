import 'package:flutter/material.dart';
import 'package:todolist/pages/todolistpage.dart';

void main() {
  runApp(const MyHome());
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  ThemeMode darkLightMode = ThemeMode.dark;
  IconData modeIcon = Icons.dark_mode;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo List",
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      themeMode: darkLightMode,
      home: ListPage(
        modeAction: GestureDetector(
          onTap: () {
            darkLightMode == ThemeMode.light
                ? darkLightMode = ThemeMode.dark
                : darkLightMode = ThemeMode.light;
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
