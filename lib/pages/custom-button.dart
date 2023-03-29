import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.onTap, required this.icon}) : super(key: key);

  final IconData icon;
  final Function()? onTap;
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
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 5),
              color: Color.fromRGBO(0, 0, 0, 0.5),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          color: _basicStates.get("darkLightMode") == 1?Colors.green.shade800:Colors.green.shade500,
        ),
        child: Icon(
          widget.icon,
          size: 35,
        ),
      ),
    );
  }
}
