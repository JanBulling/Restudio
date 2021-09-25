import 'package:flutter/material.dart';
import 'package:restudio_app/config/theme.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide the keyboard
    FocusScope.of(context).unfocus();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
