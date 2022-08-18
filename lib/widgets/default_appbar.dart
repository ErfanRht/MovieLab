import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar defaultAppBar(BuildContext context, {required final String title}) {
  return AppBar(
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
          size: 17.5,
        )),
  );
}
