import 'package:flutter/material.dart';
import 'package:restudio_app/config/theme.dart';

class CustomTextButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color? textColor;

  CustomTextButton({
    required this.onPressed,
    required this.child,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: textColor ?? black,
        minimumSize: Size(double.infinity, 50),
      ),
      child: child,
    );
  }
}
