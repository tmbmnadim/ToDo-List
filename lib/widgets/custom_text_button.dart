import 'package:flutter/material.dart';
import 'package:todolist/widgets/app_theme.dart';
import 'package:todolist/widgets/custom_button.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color =  primaryColorDay,
    this.textColor,
    this.splashColor = Colors.white24,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.fontSize = 16,
    this.width = 350,
    this.height,
  });
  final Function() onTap;
  final Color color;
  final Color? textColor;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final double fontSize;
  final double width;
  final double? height;
  final String text;

  Color invert(Color color) {
    final r = 255 - color.red;
    final g = 255 - color.green;
    final b = 255 - color.blue;

    return Color.fromARGB((color.opacity * 255).round(), r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: width,
      height: height ?? width / 8,
      color: color,
      borderColor: borderColor,
      borderWidth: borderWidth,
      splashColor: splashColor,
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor ?? invert(color),
          fontSize: fontSize,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}
