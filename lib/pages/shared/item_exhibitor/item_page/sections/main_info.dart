import 'package:flutter/material.dart';

class ItemPageMainInfo extends StatelessWidget {
  final String year;
  final String genres;
  final String runTime;
  final String contentRating;
  final String countries;
  const ItemPageMainInfo(
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
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
