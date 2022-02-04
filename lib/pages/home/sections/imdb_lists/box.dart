import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

class HomeIMDbBox extends StatelessWidget {
  String title;
  HomeIMDbBox({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: kIMDBColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            title,
            style: GoogleFonts.ubuntu(
                color: const Color(0xff000000),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset("assets/logo/IMDb.png"),
        )
      ]),
    );
  }
}
