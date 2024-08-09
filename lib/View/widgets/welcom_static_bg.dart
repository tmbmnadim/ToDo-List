import 'dart:async';

import 'package:flutter/material.dart';

class WelcomeBGStatic extends StatefulWidget {
  final double height;
  final double width;
  const WelcomeBGStatic({
    super.key,
    this.height = 200,
    this.width = 300,
  });

  @override
  State<WelcomeBGStatic> createState() => _WelcomeBGStaticState();
}

class _WelcomeBGStaticState extends State<WelcomeBGStatic> {
  bool isMorning = true;
  void changeBanner() {}

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (TimeOfDay.now().hour < 18 && !isMorning) {
        isMorning = true;
        setState(() {});
      } else if (isMorning) {
        isMorning = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: isMorning
              ? Theme.of(context).canvasColor
              : Theme.of(context).primaryColorDark,
          width: 8,
        ),
        image: DecorationImage(
          image: AssetImage(isMorning ? "assets/bg0.png" : "assets/bg1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          isMorning ? "Good Morning!" : "Good Evening!",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      // child: const AnimatedWelcomeBar(
      //   height: 200,
      // ),
    );
  }
}
