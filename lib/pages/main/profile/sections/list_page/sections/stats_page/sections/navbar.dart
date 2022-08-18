import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/capitalizer.dart';

AppBar listPageStatsNavbar(context, {required final String listName}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          listName.capitalize(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        Text(
          "stats",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.5)),
        ),
      ],
    ),
    //centerTitle: true,
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
