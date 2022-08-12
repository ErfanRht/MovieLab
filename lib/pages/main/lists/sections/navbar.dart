import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

AppBar UserListsNavbar() {
  return AppBar(
    toolbarHeight: 65,
    centerTitle: true,
    automaticallyImplyLeading: false,
    backgroundColor: kBackgroundColor,
    title: TabBar(
      unselectedLabelColor: Colors.grey.withOpacity(0.5),
      splashFactory: NoSplash.splashFactory,
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
      physics: const BouncingScrollPhysics(),
      indicatorColor: Colors.transparent,
      tabs: [
        Tab(
            child: Text(
          "Watchlist",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "History",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "Collection",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ],
    ),
  );
}