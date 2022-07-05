import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatchlistNavbar extends StatelessWidget {
  const WhatchlistNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 12.5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("collection",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.trashAlt,
              color: Colors.white,
              size: 22.5,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
