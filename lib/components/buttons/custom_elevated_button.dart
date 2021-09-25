import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color? color;

  CustomElevatedButton({required this.onPressed, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        minimumSize: Size(double.infinity, 50),
      ),
      child: child,
    );
  }
}
