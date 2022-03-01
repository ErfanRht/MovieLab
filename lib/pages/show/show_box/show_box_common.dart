import 'package:flutter/material.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';
import 'package:page_transition/page_transition.dart';

openShowPage(BuildContext context, String id) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: ShowPage(id: id)));
}
