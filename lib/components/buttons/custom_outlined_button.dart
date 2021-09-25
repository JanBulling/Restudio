import 'package:flutter/material.dart';
import 'package:restudio_app/config/theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color? color;

  CustomOutlinedButton({required this.onPressed, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: color ?? black,
        minimumSize: Size(double.infinity, 50),
      ),
      child: child,
    );
  }
}
