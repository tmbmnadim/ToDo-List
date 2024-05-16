import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    this.width,
    this.height,
    this.textSize = 16,
    this.textWeight = FontWeight.normal,
    this.hintSize = 16,
    this.hintWeight = FontWeight.normal,
    this.onChanged,
    this.onTextFieldTap,
    this.autofillHints,
    this.prefixIcon,
    this.borderRadius = BorderRadius.zero,
    this.prefixIconColor = Colors.white,
    this.suffixIcon,
    this.suffixIconColor = Colors.grey,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.focusedColor = Colors.grey,
    this.fillColor = Colors.transparent,
    this.enabledBorderColor = Colors.grey,
    this.hintColor = Colors.grey,
    this.labelColor = Colors.white,
    this.textColor = Colors.grey,
    this.cursorColor = Colors.grey,
    this.inputFormatters,
    this.maxLines = 1,
    this.textInputAction,
    this.focusNode,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 15,
    ),
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  final double? width;
  final double? height;
  final double textSize;
  final FontWeight textWeight;
  final double hintSize;
  final FontWeight hintWeight;
  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final Function(String)? onChanged;
  final Function()? onTextFieldTap;
  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;
  final Color prefixIconColor;
  final Color cursorColor;
  final Widget? suffixIcon;
  final Color suffixIconColor;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final Color focusedColor;
  final Color fillColor;
  final Color enabledBorderColor;
  final Color hintColor;
  final Color labelColor;
  final int maxLines;
  final Color textColor;
  final FocusNode? focusNode;
  final EdgeInsets contentPadding;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.textSize,
          fontWeight: widget.textWeight,
        ),
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onTap: widget.onTextFieldTap,
        maxLines: widget.maxLines,
        autofillHints: widget.autofillHints,
        cursorColor: widget.cursorColor,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          prefixIconColor: widget.prefixIconColor,
          suffixIcon: widget.suffixIcon,
          suffixIconColor: widget.suffixIconColor,
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: widget.contentPadding,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.2,
              color: Colors.white,
            ),
            borderRadius: widget.borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: widget.focusedColor,
            ),
            borderRadius: widget.borderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: widget.enabledBorderColor,
            ),
            borderRadius: widget.borderRadius,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: widget.labelColor,
            fontSize: 16,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintColor,
            fontSize: widget.hintSize,
            fontWeight: widget.hintWeight,
          ),
        ),
      ),
    );
  }
}
