import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPageMainInfo extends StatelessWidget {
  String year;
  String genres;
  String runTime;
  ShowPageMainInfo(
      {Key? key,
      required this.year,
      required this.genres,
      required this.runTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
            runTime == "" ? "$year • $genres" : "$year • $genres • $runTime",
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
