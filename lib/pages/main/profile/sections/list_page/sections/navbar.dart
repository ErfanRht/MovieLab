import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/capitalizer.dart';
import 'package:movielab/modules/navigate.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/stats.dart';

AppBar listPageNavbar(context, {required final String listName}) {
  return AppBar(
    centerTitle: false,
    backgroundColor: kBackgroundColor,
    leading: IconButton(
      icon: const Icon(
        FontAwesomeIcons.arrowLeft,
        color: Colors.white,
        size: 22.5,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Row(
      children: [
        Text(listName.capitalize(),
            style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(
          FontAwesomeIcons.squarePollVertical,
          color: Colors.white,
        ),
        onPressed: () {
          Navigate.pushTo(
              context,
              ListStatsPage(
                listName: listName,
              ));
        },
      ),
    ],
  );
}
