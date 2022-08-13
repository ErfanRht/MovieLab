import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';

AppBar defaultAppBar(BuildContext context, {required final String title}) {
  return AppBar(
    backgroundColor: kBackgroundColor,
    title: Text(
      title,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
    ),
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          FontAwesomeIcons.x,
          color: Colors.white,
          size: 17.5,
        )),
  );
}
