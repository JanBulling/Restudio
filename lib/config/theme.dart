import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Color(0xFFDF0052),
    primaryColorDark: Color(0xFF890033),
    primaryColorLight: Color(0xFFE75A8E),

    errorColor: Color(0xFF730202), // for errors in forms, ...
    hoverColor: Color(0xFFA290CE), // for links, ...
    accentColor: Colors.blue, // for stuff like snackbars
    disabledColor: COLOR_GREY,
    backgroundColor: Color(0xFFF5F5F5),
    scaffoldBackgroundColor: Colors.white,

    fontFamily: "Poppins",

    textTheme: TextTheme(
      headline1: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: COLOR_BLACK,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
      button: TextStyle(
        fontFamily: "Roboto",
      ),
    ),
  );
}

const Color COLOR_BLACK = Color(0xFF1B070B);
const Color COLOR_GREY = Color(0xFF9E9E9E);
const Color COLOR_GREY_DARKER = Color(0xFF757575);
const double PADDING = 16.0;

InputDecoration inputDecoration({required String label, IconData? icon}) => InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      labelStyle: TextStyle(color: COLOR_GREY_DARKER),
      prefixIcon: Icon(icon, color: COLOR_GREY_DARKER),
    );
