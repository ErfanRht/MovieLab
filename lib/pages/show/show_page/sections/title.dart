import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPageTitle extends StatelessWidget {
  String title;
  ShowPageTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title,
          textAlign: TextAlign.center,
          style: GoogleFonts.ubuntu(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700)),
    );
  }
}
