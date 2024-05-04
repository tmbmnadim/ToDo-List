import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:todolist/widgets/animated_welcome_bar.dart';
import 'package:todolist/widgets/app_theme.dart';
import 'package:todolist/widgets/custom_icon_button.dart';
import 'package:todolist/widgets/custom_methods.dart';
import 'package:todolist/widgets/custom_text_button.dart';
import 'package:todolist/widgets/date_list.dart';

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
                    color: isDay ? primaryNight : secondaryColorDay,
                    width: 8,
                  ),
                  vertical: BorderSide(
                    color: isDay ? primaryNight : secondaryColorDay,
                    width: 4,
                  ),
                ),
              ),
              child: AnimatedWelcomeBar(
                dayStatus: isDay ? "Good Morning" : "Good Night",
              ),
            ),
            SizedBox(
              height: scrSize.height * 0.08,
              width: scrSize.width,
              child: Row(
                children: [
                  Expanded(
                    child: CustomIconButton(
                      height: scrSize.height * 0.08,
                      backgroundColor: primaryColorDay,
                      icon: Icons.arrow_back_ios,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 1),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: primaryColorDay,
                      height: scrSize.height * 0.08,
                      child: const Center(
                        child: Text(
                          "All Tasks",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Expanded(
                    child: CustomIconButton(
                      height: scrSize.height * 0.08,
                      backgroundColor: primaryColorDay,
                      icon: Icons.arrow_forward_ios,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            DateListButtons(
              height: scrSize.height * 0.12,
              width: scrSize.width,
              dates: getDaysInMonth(DateTime.now()),
              onTap: (index) {},
            ),
            const Divider(
              color: primaryColorDay,
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: scrSize.height * 0.5 + 7,
              width: scrSize.width,
            ),
          ],
        ),
      ),
    );
  }
}
