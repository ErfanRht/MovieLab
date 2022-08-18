import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    backgroundColor: kBackgroundColor,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: kBackgroundColor),
    primaryColor: kPrimaryColor,
    brightness: Brightness.dark,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(color: Colors.white),
            primary: Colors.white)),
    textTheme: GoogleFonts.ubuntuTextTheme(
      ThemeData.dark().textTheme,
    ),
  );
}
