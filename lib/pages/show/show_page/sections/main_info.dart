import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPageMainInfo extends StatelessWidget {
  String year;
  String genres;
  String runTime;
  String contentRating;
  String countries;
  ShowPageMainInfo(
      {Key? key,
      required this.year,
      required this.genres,
      required this.runTime,
      required this.contentRating,
      required this.countries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
            runTime != "" || runTime.isNotEmpty
                ? "$year • $genres • $runTime"
                : contentRating != "" || contentRating.isNotEmpty
                    ? "$year • $genres • $contentRating"
                    : "$year • $genres • $countries",
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
