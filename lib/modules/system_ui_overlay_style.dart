import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';

setSystemUIOverlayStyle({required SystemUIOverlayStyle systemUIOverlayStyle}) {
  if (systemUIOverlayStyle == SystemUIOverlayStyle.DARK) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
  }
}
