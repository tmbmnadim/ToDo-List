import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.color = Colors.white,
    this.splashColor = Colors.white24,
    this.borderColor = Colors.transparent,
    this.textAlign = TextAlign.center,
    this.disableTextPadding = false,
    this.borderRadius = 10,
    this.borderWidth = 0,
    this.fontSize = 16,
    this.width = 350,
    this.borderRadiusValue,
    this.height,
  });
  final Function() onTap;
  final Color color;
  final Color? textColor;
  final Color splashColor;
  final Color borderColor;
  final double borderRadius;
  final BorderRadius? borderRadiusValue;
  final TextAlign textAlign;
  final double borderWidth;
  final double fontSize;
  final double width;
  final double? height;
  final String text;
  final bool disableTextPadding;

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
      borderRadius: borderRadius,
      borderRadiusValue: borderRadiusValue,
      splashColor: splashColor,
      onTap: onTap,
      child: Padding(
        padding: disableTextPadding
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: width,
          child: Text(
            text,
            textAlign: textAlign,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
