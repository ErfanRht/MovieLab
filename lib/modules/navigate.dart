import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navigate {
  static void pushTo(context, Widget page) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 250),
            child: page));
  }

  static void replaceTo(context, Widget page) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 250),
            child: page));
  }

  static void pushHeroicTo(context, Widget page) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
