import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double height;
  final double? width;
  final Color backgroundColor;
  final IconData icon;
  final Function() onPressed;
  const CustomIconButton({
    super.key,
    this.height = 300,
    this.width,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        color: backgroundColor,
        child: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
