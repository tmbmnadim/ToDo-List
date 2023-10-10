import 'package:flutter/material.dart';

class SocialSignInButton extends StatefulWidget {
  const SocialSignInButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.color,
      this.iconColor,
      this.textColor,
      required this.onTap})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final Color? iconColor;
  final Color? textColor;
  final Function() onTap;

  @override
  State<SocialSignInButton> createState() => _SocialSignInButtonState();
}

class _SocialSignInButtonState extends State<SocialSignInButton> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: widget.color,
      textColor: widget.textColor,
      title: Text(
        widget.text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      leading: Icon(
        widget.icon,
        size: 40,
        color: widget.iconColor,
      ),
    );
  }
}
