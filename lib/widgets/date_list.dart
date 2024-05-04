import 'package:flutter/material.dart';
import 'package:todolist/widgets/app_theme.dart';

import 'custom_text_button.dart';

class DateListButtons extends StatefulWidget {
  final double height;
  final double width;
  final Function(int) onTap;
  final List<String> dates;

  const DateListButtons({
    super.key,
    required this.height,
    required this.width,
    required this.onTap,
    required this.dates,
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
        itemCount: widget.dates.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (selectedIndex == index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextButton(
                text: widget.dates[index],
                width: widget.height + 20,
                fontSize: 25,
                textColor: Colors.white,
                borderColor: primaryNight,
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
              padding: const EdgeInsets.all(8.0),
              child: CustomTextButton(
                text: widget.dates[index],
                width: widget.height,
                fontSize: 25,
                textColor: Colors.white,
                onTap: () {
                  selectedIndex = index;
                  widget.onTap(index);
                  setState(() {});
                },
              ),
            );
          }
        },
      ),
    );
  }
}
