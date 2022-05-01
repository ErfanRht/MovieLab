import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

AppBar AllPopularsNavbar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
          size: 22.5,
        )),
    backgroundColor: kBlueColor,
    title: Text(title,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
  );
}
