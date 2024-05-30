import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/app_theme.dart';
import 'dart:core';

class AnimatedWelcomeBar extends StatefulWidget {
  final double height;
  const AnimatedWelcomeBar({
    super.key,
    required this.height,
  });

  @override
  State<AnimatedWelcomeBar> createState() => _AnimatedWelcomeBarState();
}

class _AnimatedWelcomeBarState extends State<AnimatedWelcomeBar>
    with TickerProviderStateMixin {
  late AnimationController dayNightAnimeController;
  late Animation inAnimation;
  late Animation rotationAnime;
  bool isItMorning = true;
  Duration duration = const Duration(seconds: 1);
  Timer? timer;

  @override
  void initState() {
    dayNightAnimeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    inAnimation = Tween<double>(begin: -2, end: 0).animate(
      CurvedAnimation(
        parent: dayNightAnimeController,
        curve: Curves.easeInOut,
      ),
    );

    rotationAnime = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: dayNightAnimeController,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    Timer.periodic(duration, (timer) {
      if (isMorning(TimeOfDay.now()) && !isItMorning) {
        inAnimation = Tween<double>(begin: 0, end: 2).animate(
          CurvedAnimation(
            parent: dayNightAnimeController,
            curve: Curves.easeInOut,
          ),
        );
        dayNightAnimeController.forward();
        if (dayNightAnimeController.isCompleted) {
          isItMorning = true;
          setState(() {});
        }
      } else if (isItMorning) {
        inAnimation = Tween<double>(begin: 0, end: 2).animate(
          CurvedAnimation(
            parent: dayNightAnimeController,
            curve: Curves.easeInOut,
          ),
        );
        dayNightAnimeController.forward();
        if (dayNightAnimeController.isCompleted) {
          isItMorning = false;
          setState(() {});
        }
      }

      inAnimation = Tween<double>(begin: -2, end: 0).animate(
        CurvedAnimation(
          parent: dayNightAnimeController,
          curve: Curves.easeInOut,
        ),
      );
    });
    return AnimatedBuilder(
      animation: dayNightAnimeController,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Container(
              color: timeDayColor(),
              height: widget.height,
              width: scrSize.width,
              child: Transform.translate(
                offset: Offset((scrSize.width * 0.5) * inAnimation.value, 0),
                child: Transform.rotate(
                  angle: (360 * rotationAnime.value) * (pi / 180),
                  child: timeIconChange(context),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset((scrSize.width * 0.5) * inAnimation.value, 5),
                child: Transform.rotate(
                  angle: (-20 * (1 - animationLastBit(rotationAnime.value))) *
                      (pi / 180),
                  child: timeTextChange(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isMorning(TimeOfDay time) {
    if (time.hour > 4 && time.hour < 18) {
      return true;
    } else {
      return false;
    }
  }

  double animationLastBit(double input) {
    if (input < 0.8) {
      return 0.0;
    } else {
      return (input - 0.8) / (1.0 - 0.8);
    }
  }

  Icon timeIconChange(BuildContext context) {
    if (isItMorning) {
      return Icon(
        Icons.sunny,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.amber
            : Colors.amber.shade600,
        size: 150,
      );
    } else {
      return const Icon(
        Icons.circle,
        color: Colors.blueGrey,
        size: 120,
      );
    }
  }

  Widget timeTextChange(BuildContext context) {
    if (isItMorning) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.amber
              : Colors.amber.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            isItMorning ? "Good Morning" : "Good Evening",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            isItMorning ? "Good Morning" : "Good Evening",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }

  Color timeDayColor({isBorder = false}) {
    if (isItMorning) {
      return isBorder ? darkModePrimary : Theme.of(context).primaryColorLight;
    } else {
      return isBorder ? lightModePrimaryLight : darkModePrimary;
    }
  }
}
