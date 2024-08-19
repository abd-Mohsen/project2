import 'package:flutter/material.dart';

import 'constants.dart';

///custom themes

class MyThemes {
  static ThemeData myLightModeEN = ThemeData.light().copyWith(
    splashColor: Colors.transparent,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f1432),
      onPrimary: Colors.white,
      secondary: Color(0xffeaaa4f),
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white70,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.grey[300]!,
      onSurface: Colors.black,
    ),
    textTheme: kMyTextTheme("english"),
  );

  static ThemeData myDarkModeEN = ThemeData.dark().copyWith(
    splashColor: Colors.transparent,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff0f1432),
      onPrimary: Colors.white,
      secondary: Color(0xffc8871e),
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white70,
      background: Color(0xff121212),
      onBackground: Color(0xffA4A4A4),
      surface: Color(0xff1e1e1e),
      onSurface: Color(0xffD7D7D7),
    ),
    textTheme: kMyTextTheme("english"),
  );

  static ThemeData myLightModeAR = myLightModeEN.copyWith(textTheme: kMyTextTheme("arabic"));
  static ThemeData myDarkModeAR = myDarkModeEN.copyWith(textTheme: kMyTextTheme("arabic"));
}
