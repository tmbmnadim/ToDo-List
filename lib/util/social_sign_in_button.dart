import 'package:flutter/material.dart';

class SocialSignInButton extends StatefulWidget {
  const SocialSignInButton(
      {Key? key,
      required this.assetPath,
      required this.text,
      required this.color,
      this.iconColor,
      this.textColor,
      required this.onPressed})
      : super(key: key);

  final String assetPath;
  final String text;
  final Color color;
  final Color? iconColor;
  final Color? textColor;
  final Function() onPressed;

  @override
  State<SocialSignInButton> createState() => _SocialSignInButtonState();
}

class _SocialSignInButtonState extends State<SocialSignInButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              width: 80,
              height: 80,
              child: Image.asset(
                widget.assetPath,
                color: widget.iconColor,
              ),
            ),Container(
              alignment: Alignment.center,
              width: 250,
              height: 80,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 22
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
