import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

class HomeIMDbBox extends StatelessWidget {
  final String title;
  const HomeIMDbBox({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: kImdbColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            title,
            style: TextStyle(
                color: const Color(0xff000000),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset("assets/images/logos/IMDb.png"),
        )
      ]),
    );
  }
}
