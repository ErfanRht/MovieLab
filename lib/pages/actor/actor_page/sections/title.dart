import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActorPageTitle extends StatelessWidget {
  String name;
  ActorPageTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(name,
          textAlign: TextAlign.center,
          style: GoogleFonts.ubuntu(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700)),
    );
  }
}
