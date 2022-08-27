import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';

final List<Map<String, dynamic>> userLists = <Map<String, dynamic>>[
  {
    "name": "watchlist",
    "icon": FontAwesomeIcons.bookmark,
    "color": Colors.blue,
    "padding": EdgeInsets.zero
  },
  {
    "name": "collection",
    "icon": FontAwesomeIcons.rectangleList,
    "color": Colors.green,
    "padding": const EdgeInsets.only(right: 2)
  },
  {
    "name": "history",
    "icon": FontAwesomeIcons.check,
    "color": kPrimaryColor,
    "padding": EdgeInsets.zero
  },
  {
    "name": "artists",
    "icon": FontAwesomeIcons.userGroup,
    "color": Colors.cyan,
    "padding": const EdgeInsets.only(right: 2.75)
  },
  {
    "name": "recommendations",
    "icon": FontAwesomeIcons.clapperboard,
    "color": Colors.deepPurpleAccent,
    "padding": EdgeInsets.zero
  },
];
