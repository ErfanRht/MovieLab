import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherRatingsBox extends StatelessWidget {
  const OtherRatingsBox(
      {Key? key, required this.rating, required this.name, required this.max})
      : super(key: key);
  final double rating;
  final int max;
  final String name;

  @override
  Widget build(BuildContext context) {
    String ratingStr;

    if (max == 100) {
      ratingStr = rating.toString().replaceAll(".0", "");
    } else {
      ratingStr = rating.toString();
    }
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 25,
      decoration: BoxDecoration(
        color: max == 100
            ? rating >= 61
                ? const Color(0xff66cc33)
                : rating >= 40
                    ? const Color(0xffffcc33)
                    : const Color(0xffff0000)
            : rating >= 6.1
                ? const Color(0xff66cc33)
                : rating >= 4.0
                    ? const Color(0xffffcc33)
                    : const Color(0xffff0000),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text("$ratingStr $name",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
