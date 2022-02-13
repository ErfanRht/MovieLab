import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  String title;
  SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12.5),
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
