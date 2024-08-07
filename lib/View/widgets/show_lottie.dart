import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';

class ShowLottie extends StatefulWidget {
  const ShowLottie({super.key});

  @override
  State<ShowLottie> createState() => _ShowLottieState();
}

class _ShowLottieState extends State<ShowLottie> with TickerProviderStateMixin {
  late AnimationController _animationController;
  // late Animation _animation;
  bool isForward = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      width: scrSize.width,
      child: Row(
        children: [
          SizedBox(
            width: scrSize.width - 200,
            height: 200,
            child: Lottie.asset(
              'assets/done.json',
              controller: _animationController,
            ),
          ),
          CustomTextButton(
            width: 200,
            height: 50,
            text: "Start/Stop",
            color: Colors.amber,
            textColor: Colors.white,
            onTap: () {
              if (_animationController.isAnimating) {
                _animationController.stop();
              } else {
                print(isForward);
                if (isForward) {
                  _animationController
                      .reverse()
                      .then((value) => isForward = false);
                }
                if (!isForward) {
                  _animationController
                      .forward()
                      .then((value) => isForward = true);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
