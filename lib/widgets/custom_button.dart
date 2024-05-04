import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({
    super.key,
    required this.child,
    required this.onTap,
    this.splashColor = Colors.white,
    this.color = Colors.black,
    this.borderColor = Colors.white,
    this.borderWidth = 0,
    this.borderRadius = 10,
    this.width = 350,
    this.height = 60,
    this.decorationImage,
  });

  final Widget child;
  final Function() onTap;
  final Color splashColor;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double width;
  final double height;
  final DecorationImage? decorationImage;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            image: decorationImage,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
