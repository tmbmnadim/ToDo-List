import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/widgets/app_theme.dart';
import 'dart:core';

class AnimatedWelcomeBar extends StatefulWidget {
  final String dayStatus;
  const AnimatedWelcomeBar({super.key, required this.dayStatus});

  @override
  State<AnimatedWelcomeBar> createState() => _AnimatedWelcomeBarState();
}

class _AnimatedWelcomeBarState extends State<AnimatedWelcomeBar>
    with TickerProviderStateMixin {
  late AnimationController dayNightAnimeController;
  late Animation inAnimation;
  late Animation rotationAnime;

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

  double animationLastBit(double input) {
    if (input < 0.8) {
      return 0.0;
    } else {
      return (input - 0.8) / (1.0 - 0.8);
    }
  }

  Icon timeIconChange() {
    if (widget.dayStatus == "Good Morning") {
      return const Icon(
        Icons.sunny,
        color: Colors.amber,
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

  Widget timeTextChange() {
    if (widget.dayStatus == "Good Morning") {
      return Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            widget.dayStatus,
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
            widget.dayStatus,
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
    if (widget.dayStatus == "Good Morning") {
      return isBorder ? primaryNight : secondaryColorDay;
    } else {
      return isBorder ? secondaryColorDay : primaryNight;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;

    // setState(() {
    //   inAnimation = Tween<double>(begin: 0, end: 2).animate(
    //     CurvedAnimation(
    //       parent: dayNightAnimeController,
    //       curve: Curves.easeInOut,
    //     ),
    //   );
    //   dayNightAnimeController.reset();
    //   dayNightAnimeController.forward();
    // });
    return AnimatedBuilder(
      animation: dayNightAnimeController,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Container(
              color: timeDayColor(),
              height: scrSize.height * 0.2,
              width: scrSize.width,
              child: Transform.translate(
                offset: Offset((scrSize.width * 0.5) * inAnimation.value, 0),
                child: Transform.rotate(
                  angle: (360 * rotationAnime.value) * (pi / 180),
                  child: timeIconChange(),
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
                  child: timeTextChange(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
