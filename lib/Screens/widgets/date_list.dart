import 'package:flutter/material.dart';
import 'package:todolist/app_theme.dart';

import 'custom_text_button.dart';

class DateListButtons extends StatefulWidget {
  final double height;
  final double width;
  final Color borderColor;
  final Color color;
  final Function(int) onTap;
  final int daysInMonth;

  const DateListButtons({
    super.key,
    required this.height,
    required this.width,
    required this.onTap,
    required this.daysInMonth,
    required this.borderColor,
    required this.color,
  });

  @override
  State<DateListButtons> createState() => _DateListButtonsState();
}

class _DateListButtonsState extends State<DateListButtons> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ListView.builder(
        itemCount: widget.daysInMonth+1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if(index == 0){
            if (selectedIndex == index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 4,
                ),
                child: CustomTextButton(
                  text: "All",
                  width: widget.height + 20,
                  fontSize: 22,
                  color: widget.color,
                  textColor: Colors.white,
                  borderColor: widget.borderColor,
                  borderWidth: 4,
                  onTap: () {
                    selectedIndex = index;
                    widget.onTap(index);
                    setState(() {});
                  },
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: CustomTextButton(
                  text: "All",
                  width: widget.height,
                  fontSize: 22,
                  color: widget.color,
                  textColor: Colors.white,
                  onTap: () {
                    selectedIndex = index;
                    widget.onTap(index);
                    setState(() {});
                  },
                ),
              );
            }
          } else{
            if (selectedIndex == index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 4,
                ),
                child: CustomTextButton(
                  text: "$index",
                  width: widget.height + 20,
                  fontSize: 22,
                  color: widget.color,
                  textColor: Colors.white,
                  borderColor: widget.borderColor,
                  borderWidth: 4,
                  onTap: () {
                    selectedIndex = index;
                    widget.onTap(index);
                    setState(() {});
                  },
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: CustomTextButton(
                  text: "$index",
                  width: widget.height,
                  fontSize: 22,
                  color: widget.color,
                  textColor: Colors.white,
                  onTap: () {
                    selectedIndex = index;
                    widget.onTap(index);
                    setState(() {});
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
