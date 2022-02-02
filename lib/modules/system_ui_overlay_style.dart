import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';

setSystemUIOverlayStyle({required SystemUIOverlayStyle systemUIOverlayStyle}) {
  if (systemUIOverlayStyle == SystemUIOverlayStyle.DARK) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
  } else if (systemUIOverlayStyle == SystemUIOverlayStyle.LIGHT) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
  }
}
