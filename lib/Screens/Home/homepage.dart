import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/widgets/animated_welcome_bar.dart';
import 'package:todolist/widgets/app_theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
    // required this.modeAction,
  }) : super(key: key);

  // final Widget modeAction;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isDay = true;
  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
        toolbarHeight: kToolbarHeight,
        centerTitle: true,
      ),
      body: SizedBox(
        height: scrSize.height - kToolbarHeight + 10,
        width: scrSize.width,
        child: Column(
          children: [
            Container(
              height: scrSize.height * 0.2,
              width: scrSize.width,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: isDay ? primaryNight : primaryDay,
                    width: 8,
                  ),
                  vertical: BorderSide(
                    color: isDay ? primaryNight : primaryDay,
                    width: 4,
                  ),
                ),
              ),
              child: AnimatedWelcomeBar(
                dayStatus: isDay ? "Good Morning" : "Good Night",
              ),
            ),
            Container(
              color: Colors.red,
              height: scrSize.height * 0.1,
              width: scrSize.width,
            ),
            Container(
              color: Colors.blue,
              height: scrSize.height * 0.1,
              width: scrSize.width,
            ),
            Container(
              color: Colors.red,
              height: scrSize.height * 0.5 + 9,
              width: scrSize.width,
            ),
          ],
        ),
      ),
    );
  }
}
