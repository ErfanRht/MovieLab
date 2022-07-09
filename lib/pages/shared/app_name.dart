import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Movie',
        style: GoogleFonts.ubuntu(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        children: const <TextSpan>[
          TextSpan(text: 'Lab', style: TextStyle(color: kPrimaryColor)),
        ],
      ),
    );
  }
}
