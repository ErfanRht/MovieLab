import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, top: 12.5, end: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "MovieLab",
            style: GoogleFonts.ubuntu(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Icon(FontAwesomeIcons.search, color: Colors.white),
        ],
      ),
    );
  }
}
