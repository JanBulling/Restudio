import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return RichText(
      text: TextSpan(
        text: "Mit der Erstellung eines Kontos erklären Sie sich mit unseren ",
        style: theme.textTheme.bodyText2,
        children: [
          TextSpan(
              text: "Nutzungsbedingungen",
              style: theme.textTheme.bodyText2!.copyWith(color: theme.hoverColor, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print("Open Terms & Conditions");
                }),
          TextSpan(
            text: " einverstanden und akzeptieren die ",
            style: theme.textTheme.bodyText2,
          ),
          TextSpan(
            text: "Datenschutzrichtlinien",
            style: theme.textTheme.bodyText2!.copyWith(color: theme.hoverColor, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print("Open Privacy Policy");
              },
          ),
        ],
      ),
    );
  }
}
