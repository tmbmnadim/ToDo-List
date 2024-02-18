import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.borderRadius,
    required this.buttonText,
  }) : super(key: key);

  final IconData icon;
  final Function()? onTap;
  final String buttonText;
  final BorderRadiusGeometry? borderRadius;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final _basicStates = Hive.box('stateBox');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 80,
        width: 120,
        decoration: BoxDecoration(
          color: _basicStates.get("darkLightMode") == 0
              ? Colors.green.shade800
              : Colors.green.shade500,
          borderRadius: widget.borderRadius,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 5),
              color: Color.fromRGBO(0, 0, 0, 0.5),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
