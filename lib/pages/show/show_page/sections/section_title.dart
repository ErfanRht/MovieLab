import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsets padding;
  const SectionTitle(
      {Key? key,
      required this.title,
      this.padding = const EdgeInsets.only(left: 10, right: 10, bottom: 12.5)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: padding,
          child: Text(title,
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
