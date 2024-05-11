import 'package:flutter/material.dart';
import 'package:todolist/widgets/custom_icon_button.dart';

class MonthViewer extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final String monthText;
  final Function() onLeft;
  final Function() onRight;
  const MonthViewer({
    super.key,
    required this.monthText,
    required this.color,
    required this.width,
    required this.height,
    required this.onLeft,
    required this.onRight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: CustomIconButton(
              height: 80,
              backgroundColor: color,
              icon: Icons.arrow_back_ios,
              onPressed: onLeft,
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            flex: 4,
            child: Container(
              color: color,
              height: 80,
              child: Center(
                child: Text(
                  monthText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            child: CustomIconButton(
              height: 80,
              backgroundColor: color,
              icon: Icons.arrow_forward_ios,
              onPressed: onRight,
            ),
          ),
        ],
      ),
    );
  }
}
