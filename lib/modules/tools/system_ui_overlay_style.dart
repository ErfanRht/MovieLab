import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';

setSystemUIOverlayStyle(
    {required SystemUIOverlayStyle systemUIOverlayStyle,
    Color color = kBackgroundColor}) {
  if (systemUIOverlayStyle == SystemUIOverlayStyle.DARK) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: color,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
  } else if (systemUIOverlayStyle == SystemUIOverlayStyle.RED) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
  }
}
